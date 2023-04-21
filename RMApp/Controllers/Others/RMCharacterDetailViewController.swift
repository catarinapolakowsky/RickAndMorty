//
//  ViewController.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 30.03.2023.
//

import UIKit
/// controller to show info about a single character
final class RMCharacterDetailViewController: UIViewController {
    
    //viewModel
    private let viewModel: RMCharacterDetailViewViewModel
    // view
    private let detailView: RMCharacterDetailView
    // MARK: - Init

    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -  Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(didTappedShare))
        title = viewModel.title
        view.addSubview(detailView)
        addConstrains()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
        
    }
    
    // MARK: - Constarains and setting up view
    private func addConstrains() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                ,
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    @objc private func didTappedShare() {
        //Share a character info
    }
}
// MARK: - Colleciton view delegate and data source

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let informationViewModel):
            return informationViewModel.count
        case .episodes(let episodeViewModel):
            return episodeViewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {

        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell
            else {fatalError()}
            cell.configure(with: viewModel)
            return cell
            
            
        case .information(let informationViewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInformationCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterInformationCollectionViewCell
            else {fatalError()}
            cell.configure(with: informationViewModel[indexPath.row])
            return cell
            
            
        case .episodes(let episodeViewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell
            else {fatalError()}
            cell.configure(with: episodeViewModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .information:
           break
        case .episodes:
            let episodes = viewModel.episodes
            let selected = episodes[indexPath.row]
            let vc = RMEpisodeDetailViewController(url: URL(string: selected))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
