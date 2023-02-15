//
//  BreedImage.swift
//  CatsApp
//
//  Created by Marat on 09.02.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let breedImage = try? JSONDecoder().decode(BreedImage.self, from: jsonData)

// MARK: - BreedImage

struct BreedImage: Codable {
    let id: String?
    let url: String?
//    let breeds: Breeds?
    let width, height: Int?
}

typealias BreedImages = [BreedImage]
