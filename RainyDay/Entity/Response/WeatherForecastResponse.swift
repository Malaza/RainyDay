//
//  WeatherForecastResponse.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

struct WeatherForecastResponse: Decodable {
    
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [ForecastResponse]?
    var city: CityResponse?
}

struct ForecastResponse: Decodable {
    
    var dt: Double?
    var main: MainResponse?
    var weather: [WeatherResponse]?
    var clouds: CloudsResponse?
    var wind: WindResponse?
    var visibility: Int?
    var pop: Double?
    var rain: RainResponse?
    var sys: SysResponse?
    var dt_txt: String?
}

struct MainResponse: Decodable {
    var temp: Double?
    var temp_kf: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
    var sea_level: Int?
    var grnd_level: Int?
}

struct WeatherResponse: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct CloudsResponse: Decodable {
    var all: Int?
}

struct WindResponse: Decodable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}

struct RainResponse: Decodable {
    var hour1: Double?
}

struct SysResponse: Decodable {
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}

struct CityResponse: Decodable {
    var id: Int?
    var name: String?
    var coord: CoordResponse?
    var country: String?
    var population: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
}

struct CoordResponse: Decodable {
    var lon: Double?
    var lat: Double?
}
