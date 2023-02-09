//
//  ParameterEncoding.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - Parameters

typealias Parameters = [String: Any]

// MARK: - NetworkError

enum NetworkError: String, Error {
    case parametersNil  = "Parameters are nil"
    case encodingFailed = "Encoding was failed"
    case missingURL     = "URL is nil"
}

// MARK: - ParameterEncoder

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
