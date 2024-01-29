//
//  WADailyTableVM.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

struct WADailyTableVM {
    var item: Daily!
    
    
    init(_ item: Daily) {
        self.item = item
    }
    
    
    var date: String {
        return item.dt.dateFormat(.day)
    }
    
    
    var temp: String {
        return "\(item.temp.min.formatTemp()) - \(item.temp.max.formatTemp())"
    }
    
    var max: String {
        return "\(item.temp.max.formatTemp())"
    }
    
    
    var image: UIImage {
        return UIHelper.getConditionImage(weatherId: item.weather.first!.id)
    }
    
    var description: String {
        guard let weather = item.weather.first else {
            return "Cool"
        }
        
        return weather.description.capitalized
    }
}


