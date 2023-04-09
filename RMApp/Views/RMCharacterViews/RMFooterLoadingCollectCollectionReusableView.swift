//
//  RMFooterLoadingCollectCollectionReusableView.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 30.03.2023.
//

import UIKit

class RMFooterLoadingCollectCollectionReusableView: UICollectionReusableView {
    
    private let spinner: UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    static let identifier = "RMFooterLoadingCollectCollectionReusableView"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
}
