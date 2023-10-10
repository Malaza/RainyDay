//
//  ForecastViewController.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import UIKit
import CoreLocation
import BackgroundTasks

class ForecastViewController: UIViewController {
    
    
    //MARK: - Outlets
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ForecastTodayTableViewCell.self, forCellReuseIdentifier: ForecastTodayTableViewCell.identifier)
        table.register(ForecastUpcomingTableViewCell.self, forCellReuseIdentifier: ForecastUpcomingTableViewCell.identifier)
        return table
    }()
    
    
    //MARK: - Variables
    var presenter: ForecastPresentable?
    var locationManager: CLLocationManager?
    let refreshControl = UIRefreshControl()
    
    
    //MARK: - Setup
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: Notification.Name(Constants.completedNotificationName), object: nil, queue: nil) { (notification) in
            self.fetchForecast()
        }
    }
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()
        registerForNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .systemBackground
    }
    
    
    //MARK: - Helper methods
    @objc private func refreshTableView() {
        fetchForecast()
    }
}


extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTodayTableViewCell.identifier) as? ForecastTodayTableViewCell {
                let model = presenter?.forecastModelAtIndex(index: indexPath.row)
                cell.configureWithModel(model: model)
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastUpcomingTableViewCell.identifier) as? ForecastUpcomingTableViewCell {
                let model = presenter?.forecastModelAtIndex(index: indexPath.row)
                cell.configureWithModel(model: model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 250 : 50
    }
}


extension ForecastViewController: ForecastViewable {
    
    func fetchForecast() {
        if locationManager?.authorizationStatus == .authorizedAlways || locationManager?.authorizationStatus == .authorizedWhenInUse {
            if let coordinate = locationManager?.location?.coordinate {
                
                self.showLoadingView()
                let request = WeatherForecastRequest(lat: coordinate.latitude, long: coordinate.longitude, cnt: 7)
                presenter?.fetchForecast(request: request)
            }
        }
    }
    
    func weatherForecastSuccess() {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.hideLoadingView()
            self.tableView.reloadData()
        }
    }
    
    func weatherForecastFailure(with error: Error) {
        showErrorMessage(message: error.localizedDescription)
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "RainyDay", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension ForecastViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch self.locationManager?.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.fetchForecast()
            break
        case .denied:
            self.showErrorMessage(message: Constants.locationPermissionError)
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showErrorMessage(message: Constants.locationPermissionError)
    }
}
