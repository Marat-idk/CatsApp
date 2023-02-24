//
//  Router.swift
//  CatsApp
//
//  Created by Marat on 24.02.2023.
//

import UIKit

// MARK: - RouterMain
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: ModuleBuilder? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(breed: Breed)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: ModuleBuilder?
    
    init(navigationController: UINavigationController, assemblyBuilder: ModuleBuilder) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createBreedsModule(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func showDetail(breed: Breed) {
        if let navigationController = navigationController {
            guard let detailVC = assemblyBuilder?.createBreedDetailModule(with: breed, and: self) else { return }
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
