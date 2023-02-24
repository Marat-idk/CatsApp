//
//  NetworkManager.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - NetworkRouterCompletion

typealias NetworkManagerCompletion = (_ data: Data?, _ respondse: URLResponse?, _ error: Error?) -> Void

// MARK: - NetworkRouter

protocol NetworkManager: AnyObject {
//    associatedtype EndPointType: EndPoint
    func request(with endpoint: EndPoint, completion: @escaping NetworkManagerCompletion)
    func cancel()
}
