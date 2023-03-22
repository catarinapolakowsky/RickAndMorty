//
//  RMEndpoint.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 22.03.2023.
//

import Foundation
/// Respresents unique API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    ///Endpoint to get episode info
    case episode
}
