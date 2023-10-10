//
//  ForecastPresenterTests.swift
//  RainyDayTests
//
//  Created by Mthokozisi Malaza on 2023/10/09.
//

import XCTest
@testable import RainyDay

final class ForecastPresenterTests: XCTestCase {
    
    var presenter: ForecastPresenter?
    
    override func setUpWithError() throws {
        let vc = ForecastViewController()
        let interactor = ForecastInteractor()
        let router = ForecastRouter()
        presenter = ForecastPresenter(interactor: interactor, router: router, view: vc)
    }
    
    func testThatPresenterInstantiated() throws {
        XCTAssertNotNil(presenter)
    }
    
    func testThatInteractorInstantiated() throws {
        XCTAssertNotNil(presenter?.interactor)
    }
    
    func testThatRouterInstantiated() throws {
        XCTAssertNotNil(presenter?.router)
    }

    func testThatVCInstantiated() throws {
        XCTAssertNotNil(presenter?.view)
    }

    override func tearDownWithError() throws {
        presenter = nil
    }
    
    func testPerformanceExample() throws {}
}
