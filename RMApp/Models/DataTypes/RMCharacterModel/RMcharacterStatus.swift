//
//  RMcharacterStatus.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 23.03.2023.
//

import Foundation
enum RMCharacterStatus: String, Codable {
    //(Alive, Dead and Unknown)
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
