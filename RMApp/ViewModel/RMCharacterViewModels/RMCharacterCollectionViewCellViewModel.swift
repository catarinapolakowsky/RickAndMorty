//
//  RMCharacterCollectionViewCellViewModel.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 26.03.2023.
//

import UIKit
final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
  
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageURL: URL?)
    {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    public var characterStatusText: String {
        return "Status: " + characterStatus.text
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        
        // TODO: - Abstract to image manager
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url, completion: completion)
    }
    // MARK: - Hashable
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
}
