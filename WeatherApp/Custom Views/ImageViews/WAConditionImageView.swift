//
//  WAConditionImageView.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

class WAConditionImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        tintColor            = .white
        layer.cornerRadius   = 10
        layer.masksToBounds  = true
    }
}

