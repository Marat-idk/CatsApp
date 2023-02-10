//
//  BreedsViewController.swift
//  CatsApp
//
//  Created by Marat on 08.02.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class BreedsViewController: UIViewController {
    
    var presenter: BreedsViewPresenterProtocol!
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        configureUI()
        view.addSubview(collectionView)
        setupConstaints()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Кошки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - configureUI
    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        // расстояние между ячейками по вертикали
        layout.minimumLineSpacing = ItemSizeConstants.lineSpacing
        // расстояние между ячейками по гаризонтали
        layout.minimumInteritemSpacing = ItemSizeConstants.interitemSpace
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(
                                                top: ItemSizeConstants.topIndent,
                                                left: ItemSizeConstants.leftIndent,
                                                bottom: ItemSizeConstants.bottomIndent,
                                                right: ItemSizeConstants.rigthIndent
                                                )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - setupConstaints
    private func setupConstaints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension BreedsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.breeds?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as? CatCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let breed = presenter.breeds?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.breed = breed
        presenter.getBreedImageLink(at: indexPath, with: breed.referenceImageID ?? "")
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BreedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ItemSizeConstants.width, height: ItemSizeConstants.height)
    }
}

// MARK: - BreedsViewProtocol protocol implementation
extension BreedsViewController: BreedsViewProtocol {
    func updateBreeds() {
        collectionView.reloadData()
    }
    
    func setBreedImage(at indexPath: IndexPath, with imgLink: String?) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CatCollectionViewCell else { return }
        
        guard let link = imgLink, let url = URL(string: link) else { return }
        
        cell.catImageView.kf.setImage(with: url)
    }
}

// MARK: ItemSizeConstants for UICollectionView
fileprivate struct ItemSizeConstants {
    // contentInset
    static let leftIndent = 12.0
    static let rigthIndent = 12.0
    static let topIndent = 12.0
    static let bottomIndent = 12.0
    
    // item spacing
    static let lineSpacing = 8.0
    static let interitemSpace = 24.0
    
    // item size
    static let width = (UIScreen.main.bounds.width - leftIndent - rigthIndent - interitemSpace) / 2
    static let height = (UIScreen.main.bounds.height - topIndent - bottomIndent - lineSpacing) / 3.2
}
