//
//  ViewController.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 22.03.2023.
//

import UIKit

/// Controll to house tabs and root tab controllers
final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupTabs()
    }
    private func configure() {
        tabBar.tintColor = .systemGreen
        tabBar.layer.borderColor = UIColor.systemGreen.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
    }
    private func setupTabs() {
        let characterVC = RMCharacterViewController()
        let episodeVC = RMEpisodeViewController()
        let locationVC = RMLocationViewController()
        let settingsVC = RMSettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: episodeVC)
        let nav3 = UINavigationController(rootViewController: locationVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
     
        
        nav1.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "list.and.film"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "wrench"), tag: 4)
        
        let navCollection = [nav1, nav2, nav3, nav4]
        for nav in navCollection {
            nav.navigationBar.prefersLargeTitles = true
            nav.children[0].navigationItem.largeTitleDisplayMode = .automatic
        }
        
        setViewControllers(navCollection, animated: true)
        
    }
    
}


