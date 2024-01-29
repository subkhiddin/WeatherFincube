//
//  WAMainVC.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation
import CoreData
import SystemConfiguration

protocol WASearchTableVCDelegate: AnyObject {
    func getCityInfo(for city: City)
}



class WAMainVC: BaseVC, CLLocationManagerDelegate, WASearchTableVCDelegate, WeatherDataDelegate {
    
    let locationManager = CLLocationManager()
    
    var scrollView: UIScrollView!
    let headerView = UIView()
    let footerView = UIView()
    
    var waModel: WAModel?
    
    private var isOfflineMode: Bool {
           return !isNetworkReachable()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewController()
        configureScrollView()
        setupUI()
        getlocationData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: headerView.frame.height + footerView.frame.height + 80)
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        view.backgroundColor = .systemBackground
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func setupUI() {
        scrollView.addSubviews(headerView, footerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(260)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-5)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(1060)
        }
    }
    
    func getlocationData() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    func getWeatherData(lat: CLLocationDegrees, lon: CLLocationDegrees, cityName: String? = nil) {
        
        if isOfflineMode {
            loadWeatherDataFromCache()
        } else {
            NetworkManager.shared.performRequest(lat: lat, lon: lon) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let waModel):
                    self.waModel = waModel
                    self.didReceiveWeatherData(waModel, cityName: cityName)
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(WASearchTableVC(delegate: self), animated: true)
    }
    
    private var requestAgainForFirstTime = true
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        getWeatherData(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if requestAgainForFirstTime {
            locationManager.requestLocation()
            requestAgainForFirstTime = false
        } else {
            let title    = "Problem with your current location data."
            let message   = "You didn't allow using your location data. But if you want to know the current weather for where you are, go to Settings and turn on Location Service for this app."
            let buttonText = "Ok"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonText, style: .default) {_ in
                let tashkentCoordinate = (41.2995, 69.2401)
                self.getWeatherData(lat: tashkentCoordinate.0, lon: tashkentCoordinate.1)
            }
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    
    func getCityInfo(for city: City) {
        guard let lat = CLLocationDegrees(city.lat), let lon = CLLocationDegrees(city.lng) else {
            print(WAError.gettingCoordinate)
            return
        }
        getWeatherData(lat: lat, lon: lon, cityName: city.name)
    }
    
    func didReceiveWeatherData(_ waModel: WAModel, cityName: String?) {
        DispatchQueue.main.async {
            self.title = self.formatCityName(waModel.timezone)
            self.add(childVC: WACurrentVC(WACurrentViewModel(waModel.current)), to: self.headerView)
            let dailyTableVC = WADailyTableVC(waModel.daily)
            dailyTableVC.waModel = waModel
            self.add(childVC: dailyTableVC, to: self.footerView)
            
        }
    }
    
    private func isNetworkReachable() -> Bool {
           var zeroAddress = sockaddr_in()
           zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
           zeroAddress.sin_family = sa_family_t(AF_INET)

           guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                   SCNetworkReachabilityCreateWithAddress(nil, $0)
               }
           }) else {
               return false
           }

           var flags: SCNetworkReachabilityFlags = []
           if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
               return false
           }

           let isReachable = flags.contains(.reachable)
           let needsConnection = flags.contains(.connectionRequired)

           return isReachable && !needsConnection
       }
    
    private func loadWeatherDataFromCache() {
        let cacheURL = NetworkManager.shared.cacheDirectory.appendingPathComponent("cachedWeatherData")
        
        if let cachedData = try? Data(contentsOf: cacheURL),
           let waModel = try? JSONDecoder().decode(WAModel.self, from: cachedData) {
            didReceiveWeatherData(waModel, cityName: nil)
        } else {
            print("Failed to load data from cache")
        }
    }
    
    
    
}
