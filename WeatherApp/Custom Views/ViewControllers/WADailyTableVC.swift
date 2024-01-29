//
//  WADailyTableVC.swift
//  WeatherApp
//
//  Created by Nuriddinov Subkhiddin on 26/01/24.
//

import UIKit

class WADailyTableVC: UITableViewController {
    
    var items: [Daily]!
    var waModel: WAModel?
    var selectedOption: Int = 0
    
    init(_ items: [Daily]) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableVC()
    }
    
    
    private func configureTableVC() {
        tableView.register(WADailyTableViewCell.self, forCellReuseIdentifier: WADailyTableViewCell.reuseIdentifier)
        tableView.separatorStyle    = .none
        tableView.backgroundColor   = .systemBackground
        tableView.isScrollEnabled   = false
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedOption {
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 7
        default:
            return items.count
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WADailyTableViewCell.reuseIdentifier, for: indexPath) as! WADailyTableViewCell
        cell.item = WADailyTableVM(items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hourlyVC = WAHourlyVC()
        hourlyVC.item = items[indexPath.row]
        hourlyVC.waModel = waModel
        
        
        
        navigationController?.pushViewController(hourlyVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel()
        headerLabel.text = "Daily forecast"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = .blue
        headerLabel.textAlignment = .left
        
        let dropdownButton = UIButton(type: .system)
        dropdownButton.setTitle("Number of days", for: .normal)
        dropdownButton.addTarget(self, action: #selector(dropdownButtonTapped), for: .touchUpInside)
        
        let headerStackView = UIStackView(arrangedSubviews: [headerLabel, dropdownButton])
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.distribution = .fill
        headerStackView.spacing = 8
        
        headerView.addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc private func dropdownButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let option1Action = UIAlertAction(title: "3 day forecast", style: .default) { _ in
            self.selectedOption = 1
            self.tableView.reloadData()
        }
        
        let option2Action = UIAlertAction(title: "5 day forecast", style: .default) { _ in
            self.selectedOption = 2
            self.tableView.reloadData()
        }
        
        let option3Action = UIAlertAction(title: "7 day forecast", style: .default) { _ in
            self.selectedOption = 3
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(option1Action)
        alertController.addAction(option2Action)
        alertController.addAction(option3Action)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

