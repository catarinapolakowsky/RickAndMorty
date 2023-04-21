//
//  RMEpisodeDetailViewController.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 21.04.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    private let url: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
