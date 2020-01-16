//
//  weatherModel.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/16/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let distance: Int?
    let title: String?
    let woeid: Int?
    
}
struct WeatherModelD: Codable {
    let consolidated_weather: [WeatherIDModel]
}

struct WeatherIDModel: Codable {
    let id: Int?
    let weather_state_name: String?
    let min_temp: Double?
    let max_temp: Double?
    let the_temp: Double?
    let wind_speed: Double?
    let wind_direction: Double?
    let air_pressure: Double?
    let humidity: Int?
    let visibility: Double?
    let predictability: Int?
    
}
