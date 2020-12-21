//
//  WeatherResponseTests.swift
//  ThermostatAppTests
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import XCTest
@testable import ThermostatApp

class WeatherResponseTests: XCTestCase {
    
    var data: Data!

    override func setUpWithError() throws {
        data = try Data(from: "weatherapi")
    }

    override func tearDownWithError() throws {
        data = nil
    }

    func testInitFromJson() throws {
        let decoder = JSONDecoder()
        let response = try decoder.decode(WeatherResponse.self, from: data)
        
        XCTAssertEqual(response.main.temp, 13.23, "Expected temp 13.23 got \(response.main.temp) instead")
    }

}
