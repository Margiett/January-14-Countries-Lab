//
//  CountryDetail.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import ImageKit
import MapKit

class CountryDetail: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryMapKit: MKMapView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    var selectedCountry: Country?
    
    var selectedWeather: WeatherModel?
    var selectedID: WeatherIDModel?
    

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
        
        populationLabel.text = "Population: \(selectedCountry?.population.description)"
        
        capitalLabel.text = "Capital: \(selectedCountry?.capital)"
         
        currencyLabel.text = "Currency: \(selectedCountry?.currencies?.first?.name ?? "")(\(selectedCountry?.currencies?.first?.symbol ?? ""))"
        
        WeatherID.getWeatherID(for: WeatherID.iD(id: selectedWeather?.woeid! ?? 1), completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let idweather):
                DispatchQueue.main.async {
                    self?.weatherLabel.text = "Weather: \(idweather.first?.weather_state_name)"
                }
            }
            
            
        })
        
        
        
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
    //MARK: This is using the mapkit
    func countryLocation() {
        let lat = selectedCountry?.latlng?.first
        let long = selectedCountry?.latlng?.last
        let location = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20) // this is how zoomed in it would be on the map
        let region = MKCoordinateRegion(center: location, span: span)
        countryMapKit.setRegion(region, animated: true)
        
        
        //MARK: This is make the red dot come up
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        annotation.title = selectedCountry?.name
        countryMapKit.addAnnotation(annotation)
        
        
        
    }
    
}
