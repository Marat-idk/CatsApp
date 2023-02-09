//
//  ParameterEncoding.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - Parameters

typealias Parameters = [String: Any]

// MARK: - ParameterEncoder

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
