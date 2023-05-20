//
//  BreedsViewController.swift
//  CatsApp
//
//  Created by Marat on 08.02.2023.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView

final class BreedsViewController: UIViewController {
    
    var presenter: BreedsViewPresenterProtocol!
    
    private var collectionView: UICollectionView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        return rc
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        // обновления поиска будет получать текущий класс
        sc.searchResultsUpdater = self
        // разрешить взаимодействие с объектами результата поиска
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Find your breed"
        return sc
    }()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        configureUI()
        view.addSubview(collectionView)
        setupConstaints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .silver), animation: nil, transition: .crossDissolve(0.25))
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Кошки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    // MARK: - configureUI
    private func configureUI() {
        configureCollectionView()
    }
    
    // MARK: - configureCollectionView
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        // расстояние между ячейками по вертикали
        layout.minimumLineSpacing = ItemSizeConstants.lineSpacing
        // расстояние между ячейками по гаризонтали
        layout.minimumInteritemSpacing = ItemSizeConstants.interitemSpace
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: BreedCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(
                                                top: ItemSizeConstants.topIndent,
                                                left: ItemSizeConstants.leftIndent,
                                                bottom: ItemSizeConstants.bottomIndent,
                                                right: ItemSizeConstants.rigthIndent
                                                )
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSkeletonable = true
        collectionView.isUserInteractionDisabledWhenSkeletonIsActive = false
    }
    
    // MARK: - setupConstaints
    private func setupConstaints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func pullToRefresh(_ sender: UIRefreshControl) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache { print("cleared") }
        presenter.getBreeds()
        sender.endRefreshing()
    }
    
}

// MARK: - UICollectionViewDataSource
extension BreedsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? (presenter.filteredBreeds?.count ?? 0) : (presenter.breeds?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.identifier, for: indexPath) as? BreedCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let breeds = isFiltering ? presenter.filteredBreeds : presenter.breeds
        
        guard let breed = breeds?[indexPath.row] else { return UICollectionViewCell() }
        
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

// MARK: - UICollectionViewDelegate
extension BreedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breeds = isFiltering ? presenter.filteredBreeds : presenter.breeds
        
        let breed = breeds?[indexPath.row]
        presenter.showDetail(with: breed)
    }
}

extension BreedsViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        BreedCollectionViewCell.identifier
    }
}

// MARK: - UISearchResultsUpdating
extension BreedsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.getFilteredBreeds(with: searchText)
    }
}

// MARK: - BreedsViewProtocol protocol implementation
extension BreedsViewController: BreedsViewProtocol {
    func updateBreeds() {
        collectionView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        collectionView.reloadData()
    }
    
    func setBreedImage(at indexPath: IndexPath, with imgLink: String?) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BreedCollectionViewCell else { return }
        
        guard let link = imgLink, let url = URL(string: link) else { return }
        
        cell.catImageView.kf.setImage(
                                with: url,
                                options: [
                                    .processor(DownsamplingImageProcessor(
                                        size: cell.catImageView.bounds.size)),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage,
                                    .transition(.fade(0.35)),
                                    .forceTransition
                                ])
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
