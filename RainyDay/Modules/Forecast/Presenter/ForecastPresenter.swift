//
//  ForecastPresenter.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

class ForecastPresenter: ForecastPresentable {
    
    var view: ForecastViewable?
    var router: ForecastRoutable?
    var interactor: ForecastInteractable?

    init(interactor: ForecastInteractable, router: ForecastRoutable, view: ForecastViewable) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Input
    func fetchForecast(request: WeatherForecastRequest) {
        interactor?.fetchForecast(request: request)
    }
    
    
    //MARK: - Output
    func interactorDidFetchWeatherForecast(with result: Result<WeatherForecastResponse, Error>) {
        
        switch result {
            case .success(let forecast):
            let model = self.transformToModelList(response: forecast)
            view?.presenterDidFetchWeatherForecast(with: .success(model))
            case .failure(let error):
            view?.presenterDidFetchWeatherForecast(with: .failure(error))
        }
    }
    
    
    //MARK: - Transform
    private func transformToModelList(response: WeatherForecastResponse) -> [WeatherForecastModel] {
        
        var array = [WeatherForecastModel]()
        
        if let response = response.list {
            for forecastResponse in response {
                let forecast = self.transformToForecastModel(response: forecastResponse)
                array.append(forecast)
            }
        }
        return array
    }
    
    private func transformToForecastModel(response: ForecastResponse) -> WeatherForecastModel {
        var model = WeatherForecastModel()
        let temp = Int(response.main?.temp ?? 0)
        model.temp = "\(temp)º"
        if let weather = response.weather?[0] {
            model.mainWeather = weather.main
        }
        return model
    }
}
