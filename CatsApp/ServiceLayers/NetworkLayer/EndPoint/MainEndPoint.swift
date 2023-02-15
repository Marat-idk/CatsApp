//
//  MainEndPoint.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - MainEndPoint

enum MainEndPoint {
    case breads
    case imagesSearch(id: String, limit: Int)
    case images(id: String)
}

// MARK: - EndPoint extension

extension MainEndPoint: EndPoint {
    var path: String {
        switch self {
        case .breads:
            return "breeds"
        case .imagesSearch:
            return "images/search"
        case .images(let id):
            return "images/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .breads:
            return .get
        case .imagesSearch:
            return .get
        case .images:
            return .get
        }
    }
    
    var task: HTTPTask {
        // FIXME: - FIX IF
        switch self {
        case .imagesSearch(id: let id, limit: let limit):
            return .requestParameters(
                            bodyParameters: nil,
                            urlParameters:
                                [
                                    "breed_ids": id,
                                    "mime_types": ["png", "jpg"],
                                    "limit": limit
                                ]
                            )
        default:
            return .request
        }
    }
}
