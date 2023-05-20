//
//  BreedsPresenter.swift
//  CatsApp
//
//  Created by Marat on 10.02.2023.
//

import Foundation

// MARK: - BreedsViewProtocol
protocol BreedsViewProtocol: AnyObject {
    func updateBreeds()
    func setBreedImage(at indexPath: IndexPath, with imgLink: String?)
}

// MARK: - BreedsViewPresenterProtocol
protocol BreedsViewPresenterProtocol: AnyObject {
    init(view: BreedsViewProtocol, service: BreedsService, router: RouterProtocol)
    func getBreeds()
    func getFilteredBreeds(with text: String)
    func getBreedImageLink(at indexPath: IndexPath, with imageId: String)
    var breeds: Breeds? { get }
    var filteredBreeds: Breeds? { get }
    func showDetail(with breed: Breed?)
}

// MARK: - BreedsPresenter
final class BreedsPresenter: BreedsViewPresenterProtocol {
    weak var view: BreedsViewProtocol?
    let networkService: BreedsService!
    let router: RouterProtocol!
    
    private(set) var breeds: Breeds? {
        didSet { view?.updateBreeds() }
    }
    
    private(set) var filteredBreeds: Breeds? {
        didSet { view?.updateBreeds() }
    }
    
    init(view: BreedsViewProtocol, service: BreedsService, router: RouterProtocol) {
        self.view = view
        self.networkService = service
        self.router = router
        getBreeds()
    }
    
    func getBreeds() {
        networkService.fetchData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let breeds):
                sleep(10)
                DispatchQueue.main.async {
                    self?.breeds = breeds
                }
            }
        }
    }
    
    func getFilteredBreeds(with text: String) {
        filteredBreeds = breeds?.filter({ breed -> Bool in
            return breed.name?.lowercased().contains(text.lowercased()) ?? false
        })
    }
    
    func getBreedImageLink(at indexPath: IndexPath, with imageId: String) {
        networkService.fecthImageLink(imageId: imageId) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let link):
                DispatchQueue.main.async {
                    self.view?.setBreedImage(at: indexPath, with: link)
                }
            }
        }
    }
    
    func showDetail(with breed: Breed?) {
        guard let breed = breed else { return }
        router.showDetail(breed: breed)
    }
}
