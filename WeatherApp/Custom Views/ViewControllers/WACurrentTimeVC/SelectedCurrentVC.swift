//
//  SelectedCurrentVC.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 27/01/24.
//

import UIKit

class SelectedCurrentVC: UIViewController {
    
    var index: Int = 0
    var item: Daily
    
    init(_ item: Daily) {
        
        self.item = item
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    
    let conditionImageView = WAConditionImageView(frame: .zero)
    let conditionLabel     = WALabel(fontSize: 28, fontName: Fonts.conditionLabelFont)
    let temperatureLabel   = WALabel(fontSize: 50, fontName: Fonts.temperatureLableFont)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        configureElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViewController() {
        view.backgroundColor        = .systemBlue.withAlphaComponent(0.8)
        view.layer.cornerRadius     = 14
        view.layer.masksToBounds    = true
        view.layer.shadowColor      = UIColor.black.cgColor
        view.layer.shadowOpacity    = 1
        view.layer.shadowOffset     = .zero
        view.layer.shadowRadius     = 10
    }
    
    private func layoutUI() {
        view.addSubviews(conditionImageView, conditionLabel, temperatureLabel)
        
        conditionImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.width.height.equalTo(90)
        }
        
        
        conditionLabel.snp.makeConstraints { make in
            make.left.equalTo(conditionImageView.snp.left)
            make.top.equalTo(conditionImageView.snp.bottom).offset(25)
        }
        
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    private func configureElements() {
        let vm = WADailyTableVM(item)
        conditionImageView.image = vm.image
        conditionLabel.text = vm.description
        temperatureLabel.text = vm.max
        
    }
    
    
    
    
}
