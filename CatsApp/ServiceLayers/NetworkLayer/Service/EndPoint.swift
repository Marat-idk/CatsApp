//
//  EndPoint.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - EndPoint

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPoint {
    var baseURL: String { "https://api.thecatapi.com/v1/" }
    var headers: HTTPHeaders? { nil }
}
