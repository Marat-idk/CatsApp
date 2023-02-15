//
//  BreedDetailPresenter.swift
//  CatsApp
//
//  Created by Marat on 15.02.2023.
//

import Foundation

// MARK: - BreedDetailViewProtocol
protocol BreedDetailViewProtocol: AnyObject {
    func setBreedImage(with link: String?)
}

protocol BreedDetailViewPresenterProtocol: AnyObject {
    var breed: Breed { get }
    
    func getBreedImage()
}

final class BreedDetailPresenter: BreedDetailViewPresenterProtocol {
    
    var breed: Breed
    weak var view: BreedDetailViewProtocol?
    let networkService: BreedImageService!
    
    init(breed: Breed, view: BreedDetailViewProtocol, service: BreedImageService) {
        self.breed = breed
        self.view = view
        self.networkService = service
    }
    
    func getBreedImage() {
        guard let id = breed.id else { return }
        networkService.fetchData(imageId: id, limit: 1) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let link):
                DispatchQueue.main.async {
                    self?.view?.setBreedImage(with: link)
                }
            }
        }
    }
}
