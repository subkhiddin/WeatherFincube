//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

struct DailyForecast: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}
