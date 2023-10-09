//
//  WeatherForecastModel.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

public enum WeatherType: String {
    case cloudy = "cloudy"
    case rainy = "rainy"
    case sunny = "sunny"
}

struct WeatherForecastModel {
    var temp: String?
    var mainWeather: String?
    var type: WeatherType = .sunny
}
