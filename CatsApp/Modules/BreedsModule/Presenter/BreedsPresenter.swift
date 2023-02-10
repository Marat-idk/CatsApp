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
    init(view: BreedsViewProtocol, service: BreedsService)
    func getBreeds()
    func getBreedImageLink(at indexPath: IndexPath, with imageId: String)
    var breeds: Breeds? { get }
}

final class BreedsPresenter: BreedsViewPresenterProtocol {
    weak var view: BreedsViewProtocol?
    let networkService: BreedsService!
    
    private(set) var breeds: Breeds? {
        didSet { view?.updateBreeds() }
    }
    
    init(view: BreedsViewProtocol, service: BreedsService) {
        self.view = view
        self.networkService = service
        getBreeds()
    }
    
    func getBreeds() {
        networkService.fetchData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let breeds):
                DispatchQueue.main.async {
                    self?.breeds = breeds
                }
            }
        }
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
}
