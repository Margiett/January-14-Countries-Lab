//
//  weatherAPIClient.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/16/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    static func getWeatherAPI(for searchQuery: String, completion: @escaping (Result<[WeatherModel], AppError>) -> ()) {
        guard let url = URL(string: searchQuery) else {
            completion(.failure(.badURL(searchQuery)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResult = try JSONDecoder().decode([WeatherModel].self, from: data)
                    completion(.success(searchResult))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
    static func lattlong(latt: Double, long: Double) -> String {
            return "https://www.metaweather.com/api/location/search/?lattlong=\(latt),\(long)"
               
           }
}

struct WeatherID {
    static func getWeatherID(for searchID: String, completion: @escaping (Result<[WeatherIDModel], AppError>) -> ()) {
        guard let url = URL(string: searchID) else {
            completion(.failure(.badURL(searchID)))
            return
        }
        let requestID = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: requestID) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResultID = try JSONDecoder().decode(WeatherModelD.self, from: data)
                    completion(.success(searchResultID.consolidated_weather))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    static func iD(id: Int ) -> String {
        return "https://www.metaweather.com//api/location/\(id)/"
        
    }
}
