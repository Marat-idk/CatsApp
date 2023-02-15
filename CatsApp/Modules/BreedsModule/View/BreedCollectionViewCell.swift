//
//  CatCollectionViewCell.swift
//  CatsApp
//
//  Created by Marat on 10.02.2023.
//

import UIKit

final class BreedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: BreedCollectionViewCell.self)
    
    public var breed: Breed? {
        didSet { self.set(with: breed) }
    }
    
    let catImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let originLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(catImageView, backView)
        backView.addSubviews(originLabel, nameLabel)
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
        backView.backgroundColor = .clear
        originLabel.text = nil
        nameLabel.text = nil
//        catImageView.kf.cancelDownloadTask()
    }
    
    // MARK: - setupConstraints
    private func setupConstraints() {
        catImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.70)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(catImageView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        originLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(originLabel.snp.bottom).offset(5)
            make.leading.equalTo(originLabel)
            make.trailing.equalTo(originLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    private func set(with breed: Breed?) {
        originLabel.text = breed?.origin
        nameLabel.text = breed?.name
    }
}
