//
//  BreedDetailViewController.swift
//  CatsApp
//
//  Created by Marat on 15.02.2023.
//

import UIKit
import Kingfisher

final class BreedDetailViewController: UIViewController {
    
    var presenter: BreedDetailViewPresenterProtocol!
    private var customView: BreedDetailView?
    
    override func loadView() {
        customView = BreedDetailView(breed: presenter.breed)
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        presenter.getBreedImage()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = presenter.breed.name
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

// MARK: - BreedDetailViewProtocol protocol implementation
extension BreedDetailViewController: BreedDetailViewProtocol {
    func setBreedImage(with link: String?) {
        guard let link = link, let url = URL(string: link) else { return }
        
        customView?.breedImageView.kf.setImage(
                                        with: url,
                                        options: [
                                            .processor(DownsamplingImageProcessor(
                                                size: customView?.breedImageView.bounds.size ?? .zero
                                                )
                                            ),
                                            .scaleFactor(UIScreen.main.scale),
                                            .cacheOriginalImage
                                        ])
    }
}
