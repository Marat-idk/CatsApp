//
//  BreedImageService.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - BreedImageService

protocol BreedImageService {
    func fetchData(imageId: String, limit: Int, _ completion: @escaping (Result<String?, Error>) -> Void)
}

struct BreedImageServiceImpl: BreedImageService {
    
    private let router: NetworkRouter
    
    init(router: NetworkRouter = Router()) {
        self.router = router
    }
    
    func fetchData(imageId: String, limit: Int, _ completion: @escaping (Result<String?, Error>) -> Void) {
        router.request(with: MainEndPoint.imagesSearch(id: imageId, limit: limit)) { data, _, error in
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
                let breedImgs = try decoder.decode([BreedImage].self, from: data)

                let breedImgsLink = breedImgs.compactMap { $0.url }
                
                completion(.success(breedImgsLink.first))
            } catch {
                completion(.failure(APIError.canNotProcessData))
            }
        }
    }
}
