//
//  File.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 22.03.2023.
//

import UIKit

/// Controller to show and search for character
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        // Do any additional setup after loading the view.
        
        RMServive.shared.execute(.listCharacterRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("***Data has been recieved")
                print("Total: \(String(model.info.count))")
                break
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
}
