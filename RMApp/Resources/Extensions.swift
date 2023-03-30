//
//  Extensions.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 25.03.2023.
//

import UIKit
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {addSubview($0)}
    }
}
