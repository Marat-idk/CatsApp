//
//  ViewController.swift
//  CatsApp
//
//  Created by Marat on 08.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var breeds: Breeds?
    
    var breadImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .blue
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        BreedsServiceImpl().fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    if (error as! APIError) == APIError.canNotProcessData {
                        print("canNotProcessData")
                    }
                case .success(let breeds):
                    self?.breeds = breeds
                }
                for breed in self!.breeds! {
                    print(breed.referenceImageID)
                }
                self?.startAnima()
            }
        }
        
        breadImageView.frame = view.bounds
        view.addSubview(breadImageView)
    }
    
    
    func setBreedImage(breed: Breed) {
        guard let breedId = breed.referenceImageID else { return }
        BreedImageServiceImpl().fetchData(imageId: breedId) { [weak self] result in
            switch result {
            case .failure:
                break
            case .success(let breedImage):
                let url = URL(string: breedImage!)
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self?.breadImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    func startAnima() {
        var breed = self.breeds![0]
        UIView.animate(withDuration: 10, delay: 1, options: .repeat, animations: { [unowned self] in
            for breed in self.breeds! {
                setBreedImage(breed: breed)
            }
        }, completion: { _ in
            breed = self.breeds![0]
            print("aga")
        })
    }


}

