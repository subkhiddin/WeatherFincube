//
//  Int+Ext.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit
enum DateFormat: String {
    case day = "dd.MM"
    case hour = "MMM d, h:mm a"
}

extension Int {
    func dateFormat(_ type: DateFormat) -> String {
        let dateFromUnix = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 5)
        
        return dateFormatter.string(from: dateFromUnix)
    }
}
