//
//  Networkable.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

protocol Networkable {
    func networkGet(request: WeatherForecastRequest) async throws -> Any
}
