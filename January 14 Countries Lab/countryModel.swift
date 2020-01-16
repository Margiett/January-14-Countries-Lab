//
//  countryModel.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import UIKit

struct Country: Codable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
    let currencies: [Currency]?
    let latlng: [Double]?
    let region: String
    
}
struct Currency: Codable {
    let code: String
    let name: String
    let symbol: String?
}
