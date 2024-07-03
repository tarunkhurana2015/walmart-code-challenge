//
//  CountryCellTableViewCell.swift
//  
//
//  Created by Tarun Khurana on 5/21/24.
//

import UIKit

class CountryCellTableViewCell: UITableViewCell {
    
    static let identifier = "CountryCell"
    
    // MARK: - Variables
    private(set) var country: CountryEntity?
    
    // MARK: - UI Components
    private let countryNameRegion: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private let countryCode: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.text = ""
        return label
    }()
    private let countryCapital: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = ""
        return label
    }()
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with country: CountryEntity) {
        self.country = country
        
        self.countryNameRegion.text = country.name + ", " + country.region
        self.countryCode.text = country.code
        self.countryCapital.text = country.capital
        
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://static.magflags.net/media/catalog/product/cache/75170699113cf9b1963820a3ea1bab40/T/H/TH-94.png")!)
            await MainActor.run {
                self.countryFlag.image = UIImage(data: data)
            }
        }
    }
    
    // TODO: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.countryNameRegion.text = nil
        self.countryCode.text = nil
        self.countryCapital.text = nil
        self.countryFlag.image = nil
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(countryNameRegion)
        self.addSubview(countryCode)
        self.addSubview(countryCapital)
        self.addSubview(countryFlag)
        
        countryNameRegion.translatesAutoresizingMaskIntoConstraints = false
        countryCode.translatesAutoresizingMaskIntoConstraints = false
        countryCapital.translatesAutoresizingMaskIntoConstraints = false
        countryFlag.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        
            countryFlag.widthAnchor.constraint(equalToConstant: 75),
            countryFlag.heightAnchor.constraint(equalToConstant: 50),
            countryFlag.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            countryFlag.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                        
            countryNameRegion.topAnchor.constraint(equalTo: self.countryFlag.topAnchor),
            countryNameRegion.leadingAnchor.constraint(equalTo: self.countryFlag.trailingAnchor, constant: 5),
            countryNameRegion.trailingAnchor.constraint(equalTo: countryCode.leadingAnchor, constant: -25),
                                                
            countryCode.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -10),
            countryCode.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                        
            countryCapital.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 5),
            countryCapital.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 10),
                        
        ])
    }
}
