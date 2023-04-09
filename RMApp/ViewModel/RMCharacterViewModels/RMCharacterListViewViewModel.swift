//
//  CharacterListViewViewModel.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 25.03.2023.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
    func didLoadMoreCharacters(at indexPath: [IndexPath])
}

final class CharacterListViewViewModel: NSObject {
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    /// observer property. each time when character has been reloaded, we go through each characters and add each to the cellViewModel with three parameters: name, status and image
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageURL: URL(string: character.image))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    /// model for cell collection data sourse
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil

    /// call this function inside initializer of CharacterListView() --- 20
    public func fetchCharacters() {
        RMServive.shared.execute(.listCharacterRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    // MARK: - Fetching Additional Characters

    /// paginate if additional characters are needed
    public func fetchAdditionalCharacters(with url: URL) {
      // if loading == false продолжаем, если true то скип
        guard !isLoadingMoreCharacters else {return}
        guard let request = RMRequest(url: url) else {
            return
        }
        isLoadingMoreCharacters = true
        
        RMServive.shared.execute(
            request,
            expecting: RMGetAllCharactersResponse.self) { [weak self]
                result in
                
                guard let strongSelf = self else {return}
                
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    
                    strongSelf.apiInfo = info
                  
                    let originalCount = strongSelf.characters.count
                    let newCount = moreResults.count
                    let total = newCount + originalCount
                    let startingIndex = total - newCount
                    let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.characters.append(contentsOf: moreResults)

                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacters(at: indexPathToAdd)
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
                self?.isLoadingMoreCharacters = false
            }
      
        
    }
    private var shouldShowMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - collection data source

extension CharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    /// data for coolection footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectCollectionReusableView
        else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

// MARK: - setting custom layout for cell

extension CharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    // episode 9
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}
// MARK: - Scroll View

extension CharacterListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let urlInfo = apiInfo?.next,
              let url = URL(string: urlInfo)
        else {return}
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            if offset >= (totalHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(with: url)
            }
            timer.invalidate()
        }
    }
}

