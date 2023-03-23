//
//  RMRequest.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 22.03.2023.
//

import Foundation
/// base url  +
/// endpoint +
/// additional path +
/// query parrameters - query is a sort of filters +
/// https://rickandmortyapi.com/api

/// Object that respresents a single API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
       }
    /// Desired Endpoints
    private let endpoint: RMEndpoint
    ///Path components for the API if any
    private let pathComponents: Set<String>
    /// query parameter for API if any
    private let queryParameters: [URLQueryItem]
    // MARK: - Creating String for URL
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        // components
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        // query
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap {
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }
        return string
    }
    // MARK: - Creating computed and cinstructed API URL

    public var url: URL? {
        return URL(string: urlString)
    }
    /// Desired HTTP method
    let httpRequest = "GET"
    // MARK: - Public intializer
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: endpoint description
    ///   - pathComponents: pathComponents description - collection of path components
    ///   - queryParameters: queryParameters description - collection of query parrameters
    public init(endpoint: RMEndpoint, pathComponents: Set<String>, queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
