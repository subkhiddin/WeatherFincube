//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import Foundation
import CoreLocation

protocol WeatherDataDelegate: AnyObject {
    func didReceiveWeatherData(_ waModel: WAModel, cityName: String?)
}

class NetworkManager {
    static let shared = NetworkManager()
    private let IP_KEY = "b06f2be68923c666bc3cfbe68d35d8a1"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&"
    
    weak var weatherDataDelegate: WeatherDataDelegate?
    
    
    internal let cacheDirectory: URL = {
            let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            return paths[0]
        }()
    
    func performRequest(lat: CLLocationDegrees, lon: CLLocationDegrees, completed: @escaping (Result<WAModel, WAError>) -> Void) {
        let endPoint = "\(baseUrl)lat=\(lat)&lon=\(lon)&appid=\(IP_KEY)&units=metric"
        print(endPoint)

        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let cacheURL = cacheDirectory.appendingPathComponent("cachedWeatherData")
               if let cachedData = try? Data(contentsOf: cacheURL),
                  let waModel = try? JSONDecoder().decode(WAModel.self, from: cachedData) {
                   completed(.success(waModel))
                   return
               }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let waModel = try decoder.decode(WAModel.self, from: data)
                
                
                try? data.write(to: cacheURL)
                completed(.success(waModel))
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}

