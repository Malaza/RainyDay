//
//  ForecastPresentable.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

protocol ForecastPresentable {
    
    var view: ForecastViewable? { get set }
    var router: ForecastRoutable? { get set }
    var interactor: ForecastInteractable? { get set }
    
    //MARK: - Input
    func fetchForecast(request: WeatherForecastRequest)
    
    
    //MARK: - Output
    func interactorDidFetchWeatherForecast(with result: Result<WeatherForecastResponse, Error>)
    func forecastModelAtIndex(index: Int) -> WeatherForecastModel?
    func numberOfItemsInSection(section: Int) -> Int?
}
