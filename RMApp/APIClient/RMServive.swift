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
    ///   - type: Type of object
    ///   - completion: callback with data or error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {}
}
/// generics  in the method allows to work with different type of data models
