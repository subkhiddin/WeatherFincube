//
//  WACurrentViewModel.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

struct WACurrentViewModel {
    
    
    var weatherInfo: Current!
    
    
    init(_ weatherInfo: Current) {
        self.weatherInfo = weatherInfo
    }
    
    
    var image: UIImage {
        return UIHelper.getConditionImage(weatherId: weatherInfo.weather.first?.id ?? 400)
    }
    
    
    var description: String {
        guard let weather = weatherInfo.weather.first else {
            return "Cool"
        }
        
        return weather.description.capitalized
    }
    
    
    var temperature: String {
        return weatherInfo.temp.formatTemp()
    }
}

