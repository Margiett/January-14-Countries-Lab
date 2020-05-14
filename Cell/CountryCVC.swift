//
//  CountryCVC.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import ImageKit


class CountryCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitaLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    public func configureCell(for country: Country) {
        countryNameLabel.text = country.name
        countryCapitaLabel.text = country.capital
        countryPopulationLabel.text = country.population.description
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
        
             countryImage.getImage(with: imageURL) { [weak self] (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.countryImage.image = UIImage(systemName: "exclamationmark-triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.countryImage.image = image
                    }
                }
            }
        }
    }

// testing ...
