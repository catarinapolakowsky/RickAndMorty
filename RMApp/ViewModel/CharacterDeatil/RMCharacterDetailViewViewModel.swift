//
//  RMCharacterDetailViewViewModel.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 30.03.2023.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
        case information(viewModel: [RMCharacterInformationCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init

    private let character: RMCharacter
    public var episodes: [String] {
        character.episode
    }
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    private var requestUrl: URL? {
        URL(string: character.url)
    }
    public var title: String {
        character.name.uppercased()
    }
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            
                .information(viewModel: [.init(value: character.status.text, type: .status),
                                         .init(value: character.gender.rawValue, type: .gender),
                                         .init(value: character.type, type: .type),
                                         .init(value: character.species, type: .spicies),
                                         .init(value: character.origin.name, type: .origin),
                                         .init(value: character.location.name, type: .location),
                                         .init(value: "\(character.episode.count)", type: .episodeCount),
                                         .init(value: character.created, type: .created)]),
            
                .episodes(viewModel: character.episode.compactMap {
                    return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
                }),
        ]
    }
// 1
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
  // 2
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8)
        //
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        //
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    //3
    public func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3,
            leading: 3,
            bottom: 3,
            trailing: 3)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
 
}
// the way we built relationship among DETAIL controller, model and view model differs from what i've done for the character part of controllers, view models and models

/// so we basically change the pattern. instead of delegate data sourse and the delegate of Collection view inside view model as we did for characters model, with character detail we are doign the same thing in view controller
