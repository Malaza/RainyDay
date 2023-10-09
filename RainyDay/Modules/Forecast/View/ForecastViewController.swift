//
//  ForecastViewController.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {

    //MARK: - Outlets
    private let tableView: UITableView = {
        let table = UITableView()
//        table.register("", forCellReuseIdentifier: "")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: - Variables
    var presenter: ForecastPresentable?
    
    var locationManager: CLLocationManager?
    
    var forecastModelList: [WeatherForecastModel]?
    
    
    //MARK: - Setup
    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
    }
    
    
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
        self.view.backgroundColor = .blue
    }

}


extension ForecastViewController: ForecastViewable {
    
    func fetchForecast() {
        if locationManager?.authorizationStatus == .authorizedAlways ||
            locationManager?.authorizationStatus == .authorizedWhenInUse {
            if let coordinate = locationManager?.location?.coordinate {
                let request = WeatherForecastRequest(lat: coordinate.latitude,
                                                    long: coordinate.longitude,
                                                    cnt: 7)
                presenter?.fetchForecast(request: request)
            }
        }
    }
    
    func presenterDidFetchWeatherForecast(with result: Result<[WeatherForecastModel], Error>) {
        
        switch result {
        case .success(let modelList):
            self.forecastModelList = modelList
        case .failure(let error):
            showErrorMessage(message: error.localizedDescription)
        }
    }
    
}


extension ForecastViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch self.locationManager?.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.fetchForecast()
        case .denied:
            self.showErrorMessage(message: "This app uses your location to improve your app experience. Please allow location permission")
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showErrorMessage(message: "This app uses your location to improve your app experience. Please allow location permission")
    }
}
