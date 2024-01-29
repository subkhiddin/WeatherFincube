//
//  Current.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

struct Current: Decodable {
    let temp: Double
    let weather: [Weather]
}

