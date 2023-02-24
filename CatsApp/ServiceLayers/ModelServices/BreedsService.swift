//
//  BreedsService.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - BreedsService

protocol BreedsService {
    func fetchData(_ completion: @escaping (Result<Breeds, Error>) -> Void)
    func fecthImageLink(imageId: String, _ completion: @escaping (Result<String?, Error>) -> Void)
}

// MARK: - BreedsServiceImpl

struct BreedsServiceImpl: BreedsService {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManagerImpl()) {
        self.networkManager = networkManager
    }
    
    func fetchData(_ completion: @escaping (Result<Breeds, Error>) -> Void) {
        networkManager.request(with: MainEndPoint.breads) { data, _, error in
            guard error == nil else {
                completion(.failure(NetworkError.connectionFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let breeds = try decoder.decode(Breeds.self, from: data)
                completion(.success(breeds))
            } catch {
                completion(.failure(APIError.canNotProcessData))
            }
        }
    }
    
    func fecthImageLink(imageId: String, _ completion: @escaping (Result<String?, Error>) -> Void) {
        networkManager.request(with: MainEndPoint.images(id: imageId)) { data, _, error in
            guard error == nil else {
                completion(.failure(NetworkError.connectionFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let breedImg = try decoder.decode(BreedImage.self, from: data)
                completion(.success(breedImg.url))
            } catch {
                completion(.failure(APIError.canNotProcessData))
            }
        }
    }
}
