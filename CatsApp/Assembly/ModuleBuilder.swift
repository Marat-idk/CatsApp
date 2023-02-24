//
//  ModuleBuilder.swift
//  CatsApp
//
//  Created by Marat on 10.02.2023.
//

import UIKit

// MARK: - ModuleBuilder
protocol ModuleBuilder {
    func createBreedsModule(router: RouterProtocol) -> UIViewController
    func createBreedDetailModule(with breed: Breed, and router: RouterProtocol) -> UIViewController
}

// MARK: - ModuleBuilderImpl
class ModuleBuilderImpl: ModuleBuilder {
    
    func createBreedsModule(router: RouterProtocol) -> UIViewController {
        let view = BreedsViewController()
        let service = BreedsServiceImpl()
        let presenter = BreedsPresenter(view: view, service: service, router: router)
        view.presenter = presenter
        return view
    }
    
    func createBreedDetailModule(with breed: Breed, and router: RouterProtocol) -> UIViewController {
        let view = BreedDetailViewController()
        let service = BreedImageServiceImpl()
        let presenter = BreedDetailPresenter(breed: breed, view: view, service: service, router: router)
        view.presenter = presenter
        return view
    }
}
