//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 13.04.2023.
//

import Foundation
final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    public func fetchImage(complectionHandler: @escaping (Result<Data,Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            complectionHandler(.failure(URLError(.badURL)))
            return}
        RMImageLoader.shared.downloadImage(imageUrl, completion: complectionHandler)
    }
}
