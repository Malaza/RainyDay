//
//  WeatherForecastMapper.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/09.
//

import Foundation

class WeatherForecastMapper {
    
    static let rainCode = 500...600
    static let cloudCode = 800...900
    
    
    //MARK: - Transform
    public static func transformToModelList(response: WeatherForecastResponse) -> [WeatherForecastModel] {
        
        var array = [WeatherForecastModel]()
        
        if let response = response.list {
            for forecastResponse in response {
                let forecast = self.transformToForecastModel(response: forecastResponse)
                array.append(forecast)
            }
        }
        return array
    }
    
    private static func transformToForecastModel(response: ForecastResponse) -> WeatherForecastModel {
        
        var model = WeatherForecastModel()
        model.dt = transformUnixDateToDay(dt: response.dt ?? 0)
        
        let temp = Int(response.main?.temp ?? 0)
        model.temp = "\(temp)º"
        
        let tempMin = Int(response.main?.temp_min ?? 0)
        model.tempMin = "\(tempMin)º"
        
        let tempMax = Int(response.main?.temp_max ?? 0)
        model.tempMax = "\(tempMax)º"
        
        if response.weather?.count ?? 0 > 0 {
            if let weather = response.weather?.last {
                model.mainWeather = weather.main
                model.icon = weather.icon
            }
        }
        return model
    }
    
    private static func transformUnixDateToDay(dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
