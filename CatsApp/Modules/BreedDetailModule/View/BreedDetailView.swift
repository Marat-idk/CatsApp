//
//  BreedDetailView.swift
//  CatsApp
//
//  Created by Marat on 15.02.2023.
//

import UIKit

final class BreedDetailView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var stackView: UIStackView!
    
    private let breed: Breed
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let breedImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var temperamentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = breed.temperament
        lbl.font = .systemFont(ofSize: 30)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = breed.description
        lbl.font = .systemFont(ofSize: 22)
        lbl.textColor = .black
        lbl.textAlignment = .natural
        lbl.numberOfLines = 0
        return lbl
    }()
    
    init(breed: Breed) {
        self.breed = breed
        super.init(frame: .zero)
        
        configureMainStackView()
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(backView, descriptionLabel)
        backView.addSubviews(breedImageView,
                             temperamentLabel,
                             stackView
                            )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
        breedImageView.layer.cornerRadius = breedImageView.bounds.height / 2
    }
    
    // MARK: - setupConstraints
    private func setupConstraints() {
        //
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.7).priority(.low)
        }
        
        breedImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        temperamentLabel.snp.makeConstraints { make in
            make.top.equalTo(breedImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(temperamentLabel.snp.bottom).offset(20)
            make.leading.equalTo(temperamentLabel)
            make.trailing.equalTo(temperamentLabel)
            make.height.greaterThanOrEqualTo(250)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    private func configureMainStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        
        stackView.addArrangedSubview(
            generateHorizontalStackView(
                first: ("Adaptability", breed.adaptability ?? 0),
                second: ("Affection level", breed.affectionLevel ?? 0)
            )
        )
        
        stackView.addArrangedSubview(
            generateHorizontalStackView(
                first: ("Child friendly", breed.childFriendly ?? 0),
                second: ("Dog friendly", breed.dogFriendly ?? 0)
            )
        )

        stackView.addArrangedSubview(
            generateHorizontalStackView(
                first: ("Energy level", breed.energyLevel ?? 0),
                second: ("Grooming", breed.grooming ?? 0)
            )
        )
        
        stackView.addArrangedSubview(
            generateHorizontalStackView(
                first: ("Health issues", breed.healthIssues ?? 0),
                second: ("Intelligence", breed.intelligence ?? 0)
            )
        )
    }
    
    // MARK: - generate horizontal stackview
    private func generateHorizontalStackView(first: (String, Int), second: (String, Int)) -> UIStackView {
        let stackView = UIStackView(frame: .init(x: 0, y: 0, width: 150, height: 80))
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.addArrangedSubview(generateMark(text: first.0, stars: first.1))
        stackView.addArrangedSubview(generateMark(text: second.0, stars: second.1))
        
        return stackView
    }
    
    // MARK: - generate mark unit
    private func generateMark(text: String, stars: Int) -> UIView {
        let view = UIView()
//        view.backgroundColor = .cyan
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .lightGray
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        let starsView = generateStarsImages(stars: stars)

        view.addSubview(starsView)
        starsView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        
        return view
    }
    
    // MARK: - generate stars images in stackview
    private func generateStarsImages(stars: Int) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        
        for star in 1...5 {
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            imgView.contentMode = .scaleAspectFit
            imgView.image = UIImage(systemName: star <= stars ? "star.fill" : "star")
            imgView.tintColor = .yellow
            stackView.addArrangedSubview(imgView)
        }
        return stackView
    }
}
