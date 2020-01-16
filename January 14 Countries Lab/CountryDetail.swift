//
//  CountryDetail.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import MapKit

class CountryDetail: UIViewController {
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryMapKit: MKMapView!
    
    
    
    var selectedCountry: Country?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        countryLocation()

    }
    
    func loadData() {
        guard let countryData = selectedCountry else {
            fatalError("segue did not work")
        }
        nameLabel.text = selectedCountry?.name
        populationLabel.text = selectedCountry?.population.description
        capitalLabel.text = selectedCountry?.capital
        
        
        let imageURL = "https://www.countryflags.io/\(selectedCountry!.alpha2Code)/flat/64.png"
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
    
    func countryLocation() {
        let lat = selectedCountry?.latlng?.first
        let long = selectedCountry?.latlng?.last
        let location = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20) // this is how zoomed in it would be on the map
        let region = MKCoordinateRegion(center: location, span: span)
        countryMapKit.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        annotation.title = selectedCountry?.name
        countryMapKit.addAnnotation(annotation)
        
        
        
    }
    
}
