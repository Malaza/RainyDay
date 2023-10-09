//
//  ForecastRouter.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import Foundation

class ForecastRouter: ForecastRoutable {

    var presenter: ForecastPresentable?

    static func setupModule() -> ForecastViewController {
        let vc = ForecastViewController()
        let interactor = ForecastInteractor()
        let router = ForecastRouter()
        let presenter = ForecastPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
}
