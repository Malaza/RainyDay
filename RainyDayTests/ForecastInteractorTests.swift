//
//  ForecastInteractorTests.swift
//  RainyDayTests
//
//  Created by Mthokozisi Malaza on 2023/10/09.
//

import XCTest
@testable import RainyDay

enum TestError: Error {
    case interactorInstantiationFailed
}

final class ForecastInteractorTests: XCTestCase {
    
    var interactor: ForecastInteractor?
    
    override func setUpWithError() throws {
        let vc = ForecastViewController()
        interactor = ForecastInteractor()
        let router = ForecastRouter()
        guard let nonEmptyInteractor = interactor else { throw TestError.interactorInstantiationFailed }
        let presenter = ForecastPresenter(interactor: nonEmptyInteractor, router: router, view: vc)
        vc.presenter = presenter
        interactor?.presenter = presenter
    }

    
    
    func testThatServiceIsAvailable() throws {
        XCTAssertNotNil(interactor?.service)
    }

    func testThatInteractorInstantiated() throws {
        XCTAssertNotNil(interactor?.presenter)
    }
    
    func testThatRouterInstantiated() throws {
        XCTAssertNotNil(interactor?.presenter?.router)
    }

    func testThatVCInstantiated() throws {
        XCTAssertNotNil(interactor?.presenter?.view)
    }
    
    func testPerformanceExample() throws {}
    
    override func tearDownWithError() throws {
        interactor = nil
    }
}
