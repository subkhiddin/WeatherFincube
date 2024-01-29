//
//  Daily.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}
