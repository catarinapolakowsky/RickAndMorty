//
//  RmCharacterGender.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 23.03.2023.
//

import Foundation
enum RMCharacterGender: String, Codable {
    ///The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case`unknown` = "unknown"
}
