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
    var forecastModelList: [WeatherForecastModel]?

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
            let modelList = WeatherForecastMapper.transformToModelList(response: forecast)
            self.forecastModelList = modelList
            view?.weatherForecastSuccess()
            case .failure(let error):
            view?.weatherForecastFailure(with: error)
        }
    }
    
    func forecastModelAtIndex(index: Int) -> WeatherForecastModel? {
        return self.forecastModelList?[index]
    }
    
    func numberOfItemsInSection(section: Int) -> Int? {
        return section == 0 ? 1 : (self.forecastModelList?.count ?? 0 - 1)
    }
}
