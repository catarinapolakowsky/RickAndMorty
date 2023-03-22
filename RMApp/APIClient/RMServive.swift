//
//  File.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 22.03.2023.
//

import Foundation
/// Priamary API service to get Rick and Morty data
final class RMServive {
    /// shared singleton instance
    static let shatred = RMServive()
    
    /// privatized constructor
    private init() {}
    
    /// Send Rick and Morty API
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {}
}
