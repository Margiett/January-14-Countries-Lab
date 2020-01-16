//
//  APIClient.swift
//  January 14 Countries Lab
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPIClient {
     static func fetchCountries(for searchQuery: String, completion: @escaping (Result<[Country], AppError>) -> ()) {
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "colombia"
        
        let endPointURL =  "https://restcountries.eu/rest/v2/name/\(searchQuery.lowercased())"
        
        guard let url = URL(string: endPointURL) else {
            completion(.failure(.badURL(endPointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResult = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(searchResult))

                }catch{
                    completion(.failure(.decodingError(error)))
                }

            }
        }
    }
}


