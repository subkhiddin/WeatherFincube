//
//  Double+Ext.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

extension Double {
    func formatTemp() -> String {
        return "\(String(format: "%.1f", self))°C"
    }
}
