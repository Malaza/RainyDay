//
//  ForecastViewable.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

protocol ForecastViewable {
    func fetchForecast()
    func weatherForecastSuccess()
    func weatherForecastFailure(with error: Error)
}
