//
//  ModuleBuilder.swift
//  CatsApp
//
//  Created by Marat on 10.02.2023.
//

import UIKit

// MARK: - ModuleBuilder

protocol ModuleBuilder {
    static func createBreedsModule() -> UIViewController
    static func createBreedDetailModule(with breed: Breed) -> UIViewController
}

// MARK: - ModuleBuilderImpl

enum ModuleBuilderImpl: ModuleBuilder {
    
    static func createBreedsModule() -> UIViewController {
        let view = BreedsViewController()
        let service = BreedsServiceImpl()
        let presenter = BreedsPresenter(view: view, service: service)
        view.presenter = presenter
        return view
    }
    
    static func createBreedDetailModule(with breed: Breed) -> UIViewController {
        let view = BreedDetailViewController()
        let service = BreedImageServiceImpl()
        let presenter = BreedDetailPresenter(breed: breed, view: view, service: service)
        view.presenter = presenter
        return view
    }
}
