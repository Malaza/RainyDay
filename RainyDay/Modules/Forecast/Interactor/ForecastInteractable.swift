//
//  ForecastInteractable.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

protocol ForecastInteractable {
    
    var presenter: ForecastPresentable? { get set }
    
    func fetchForecast(request: WeatherForecastRequest)
}
