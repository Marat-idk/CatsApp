//
//  NetworkRouter.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - networkRouterCompletion

typealias networkRouterCompletion = (_ data: Data?, _ respondse: URLResponse?, _ error: Error?) -> Void

// MARK: - NetworkRouter

protocol NetworkRouter: AnyObject {
//    associatedtype EndPointType: EndPoint
    func request(with endpoint: EndPoint, completion: @escaping networkRouterCompletion)
    func cancel()
}