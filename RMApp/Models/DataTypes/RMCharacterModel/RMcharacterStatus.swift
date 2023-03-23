//
//  RMcharacterStatus.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 23.03.2023.
//

import Foundation
enum RMCharacterStatus: String, Codable {
    //(Alive, Dead and Unknown)
    case alice = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}
