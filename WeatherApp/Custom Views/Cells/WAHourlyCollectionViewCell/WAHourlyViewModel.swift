//
//  WAHourlyViewModel.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

struct WAHourlyViewModel {
    
    var item: Hourly!
    
    init(_ hourlyInfo: Hourly) {
        self.item = hourlyInfo
    }
    
    
    var temperature: String {
        return item.temp.formatTemp()
    }
    
    
    var date: String {
        return item.dt.dateFormat(.hour)
    }
    
    
    var image: UIImage {
        return UIHelper.getConditionImage(weatherId: item.weather.first?.id ?? 400)
    }
}


