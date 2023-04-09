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
    static let shared = RMServive()
    
    /// privatized constructor
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
        case failedToDecodeData
    }
    
    /// Send Rick and Morty API
    /// - Parameters:
    ///   - request: Request Instance
    ///   - type: Type of object, pass a prefarable type(character, location, episode), needs to be decoded to the specific type, so pass type when calling the function
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T,RMServiceError>) -> Void) {
            
            guard let urlRequest = self.request(from: request) else {
                completion(.failure(.failedToCreateRequest))
                return
            }
            let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure( .failedToGetData))
                    return
                }
                print(request.url?.absoluteString ?? "")
                //Decode Response
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(.failedToDecodeData))
                }
            }
            task.resume()
    }
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpRequest
        return request
    }
}

///Notes along:
/// generics  in the method allows to work with different type of data models

///By creating a task based on a request object, you can tune various aspects of the task’s behavior, including the cache policy and timeout interval.
