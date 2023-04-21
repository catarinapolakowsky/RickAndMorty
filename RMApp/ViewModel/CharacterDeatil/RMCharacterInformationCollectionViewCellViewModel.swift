//
//  RMCharacterInformationCollectionViewCellViewModel.swift
//  RMApp
//
//  Created by Catarina Polakowsky on 13.04.2023.
//

import UIKit
final class RMCharacterInformationCollectionViewCellViewModel {
    private let type: InfoType
    private let value: String
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()

    static let shortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title: String {
        self.type.displayTitle
    }
    public var displayValue: String {
        if value.isEmpty {
            return "No Information"
        }
       
        if let date = Self.dateFormatter.date(from: value),
            type == .created {
            let newDate = Self.shortFormatter.string(from: date)
            return newDate
        }
        return value
    }
    public var iconImage: UIImage? {
        return type.iconImage
    }
    public var tintImageColor: UIColor {
        return type.tintColor
    }
    
    init(value: String, type: InfoType) {
        self.value = value
        self.type = type
    }
    
    enum InfoType: String {
        case status
        case gender
        case spicies
        case origin
        case created
        case episodeCount
        case location
        case type
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemRed
            case .gender:
                return .systemBlue
            case .spicies:
                return .systemPink
            case .origin:
                return .systemMint
            case .created:
                return .systemYellow
            case .episodeCount:
                return .systemOrange
            case .location:
                return .systemPurple
            case .type:
                return .systemGreen
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .spicies:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            
            switch self {
            case .status,
           .gender,
           .spicies,
           .origin,
           .created,
           .location,
           .type:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
        
    }
}
