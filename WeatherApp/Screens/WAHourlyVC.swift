//
//  WAHourlyVC.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 27/01/24.
//

import UIKit


class WAHourlyVC: BaseVC {
    
    
    
    var scrollView : UIScrollView!
    let firtsView = UIView()
    let secondView = UIView()
    
    var item: Daily?
    var waModel: WAModel?
    var hourlyData: [Hourly]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        setupUI()
        view.backgroundColor = .white
        
        DispatchQueue.main.async { [self] in
            if let item = item {
                let selectedVC = SelectedCurrentVC(item)
                self.add(childVC: selectedVC, to: self.firtsView)
            }
            
            if let hourlyData = waModel?.hourly {
                self.add(childVC: WAHourlyCollectionVC(hourlyData), to: self.secondView)
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: screensize.width, height: firtsView.frame.height + secondView.frame.height + 50)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screensize.width, height: screensize.height))
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func setupUI() {
        scrollView.addSubviews(firtsView,secondView)
        
        
        firtsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(screensize.width - 30)
            make.height.equalTo(260)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(firtsView.snp.bottom)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(screensize.width)
            make.height.equalTo(220)
        }
    }
    
    
    
    
}
