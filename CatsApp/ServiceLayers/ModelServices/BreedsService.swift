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
}

// MARK: - BreedsServiceImpl

struct BreedsServiceImpl: BreedsService {
    
    private let router: NetworkRouter
    
    init(router: NetworkRouter = Router()) {
        self.router = router
    }
    
    func fetchData(_ completion: @escaping (Result<Breeds, Error>) -> Void) {
        router.request(with: MainEndPoint.breads) { data, _, error in
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
}
