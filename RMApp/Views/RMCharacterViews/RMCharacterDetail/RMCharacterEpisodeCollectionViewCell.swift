import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - UI Elements for Cell
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 2
        //contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.systemGreen.cgColor
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        setupConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
           nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
           nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
           nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
        ])
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
        viewModel.registerForData { [weak self] data in
                // Main Queue
            self?.seasonLabel.text = data.episode
            self?.nameLabel.text = "Episode " + data.name
            self?.airDateLabel.text = "Aired on " + data.air_date
        }
        viewModel.fetchEpisode()
    }
}
