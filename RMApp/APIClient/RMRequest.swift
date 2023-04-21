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
    private let pathComponents: [String]
    /// query parameter for API if any
    private let queryParameters: [URLQueryItem]
    
    
    // MARK: - Creating String for URL
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        // PATH components
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        // Query Items
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
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
    /// Attempt to create a Request
    /// - Parameter url: URL
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        // delete base url + / to create parameters and query items if any
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            // возвращает array of elements separates with a question mark
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}
extension RMRequest {
    static let listCharacterRequest = RMRequest(endpoint: .character)
}
