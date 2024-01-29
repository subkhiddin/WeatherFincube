//
//  Hourly.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

