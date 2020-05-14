//
//  ViewController.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherCountry = [WeatherModel]()
    
    
    var searchQuery = "united" {
        didSet {
            searchCountry()
        }
    }
    
    var countriesDidSet = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
         searchCountry()
        
    }
    func searchCountry() {
           CountryAPIClient.fetchCountries(for: "\(searchQuery)", completion: { [weak self] (result) in
               switch result {
               case .failure(let appError):
                   print("error \(appError)")
               case .success(let countries):
                   self?.countriesDidSet = countries
               }
           })
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let countryDetail = segue.destination as? CountryDetail,
            let indexPath = collectionView.indexPathsForSelectedItems?.first else {
                fatalError("this did not work")
            }
        countryDetail.selectedCountry = countriesDidSet[indexPath.row]
        
        WeatherAPIClient.getWeatherAPI(for: WeatherAPIClient.lattlong(latt: countriesDidSet[indexPath.row].latlng?[0] ?? 0.0, long: countriesDidSet[indexPath.row].latlng?[1] ?? 1.1 ), completion:{ [weak self] (result) in
            switch result {
            case .failure(let appError):
            print("error \(appError)")
            case .success(let weather):
                countryDetail.selectedWeather = weather.first
                
                
            }
            })
        sleep(3)
        }
}



extension CountryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchBar.text!
    }
}


extension CountryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return countriesDidSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCVC else {
            fatalError("Could not type cast reusable cell")
        }
        let countryImage = countriesDidSet[indexPath.row]
        cell.configureCell(for: countryImage)
        //cell.configureCell(for: countryImage)
        return cell
    }
}

extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let interItemSpacing = CGFloat(1)
            let maxWidth = UIScreen.main.bounds.size.width // device's width
    //      let maxHeight = UIScreen.main.bounds.size.height
            let numberOfItems: CGFloat = 1 // items per row
            let totalSpacing: CGFloat = numberOfItems * interItemSpacing
            let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
            
            //this sizing is so it prints squares.
            return CGSize(width: itemWidth, height: itemWidth)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
        
}



