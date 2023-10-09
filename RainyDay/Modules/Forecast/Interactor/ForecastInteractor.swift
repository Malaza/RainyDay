//
//  ForecastInteractor.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

class ForecastInteractor: ForecastInteractable {
    
    let service = Network()
    var presenter: ForecastPresentable?
        
    func fetchForecast(request: WeatherForecastRequest) {
        
        Task {
            
            let result = try await self.service.networkGet(request: request)

            do {
                let forecast = try JSONDecoder().decode(WeatherForecastResponse.self, from: result as! Data)
                presenter?.interactorDidFetchWeatherForecast(with: .success(forecast))
            }
            catch {
                presenter?.interactorDidFetchWeatherForecast(with: .failure(error))
            }
        }
    }
    
}
