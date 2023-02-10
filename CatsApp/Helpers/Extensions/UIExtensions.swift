//
//  UIExtensions.swift
//  CatsApp
//
//  Created by Marat on 10.02.2023.
//

import UIKit

// MARK: - UIView extension
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
