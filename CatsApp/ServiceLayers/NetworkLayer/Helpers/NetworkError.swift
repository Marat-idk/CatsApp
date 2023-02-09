//
//  NetworkError.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: String, Error {
    case connectionFailed   = "Connection failed"
    case parametersNil      = "Parameters are nil"
    case encodingFailed     = "Encoding was failed"
    case missingURL         = "URL is nil"
}
