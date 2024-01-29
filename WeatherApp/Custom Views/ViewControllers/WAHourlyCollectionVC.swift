//
//  WAHourlyCollectionVC.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

class WAHourlyCollectionVC: UICollectionViewController {
    let numberOfItems: Int = 8
    
    var items: [Hourly]!
    
    init(_ items: [Hourly]) {
        super.init(collectionViewLayout: UIHelper.createFlowLayout())
        self.items = Array(items[0..<numberOfItems])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionVC()
    }
    
    
    private func configureCollectionVC() {
        collectionView.register(WAHourlyCollectionViewCell.self, forCellWithReuseIdentifier: WAHourlyCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor                 = .white
        collectionView.showsHorizontalScrollIndicator  = false
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WAHourlyCollectionViewCell.reuseIdentifier, for: indexPath) as? WAHourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.item = WAHourlyViewModel(items[indexPath.row])
        return cell
    }
}
