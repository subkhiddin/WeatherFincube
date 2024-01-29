//
//  WAModel.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

struct WAModel: Decodable {
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

