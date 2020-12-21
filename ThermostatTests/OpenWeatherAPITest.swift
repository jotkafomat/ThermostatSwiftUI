//
//  OpenWeatherAPITest.swift
//  ThermostatAppTests
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import XCTest
@testable import ThermostatApp
import Combine

class OpenWeatherAPITest: XCTestCase {
    
    var api: OpenWeatherAPI!
    let baseUrl = URL(string: "https://just.test/")
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        
        api = OpenWeatherAPI(session: session, baseUrl: baseUrl!)
    }

    override func tearDownWithError() throws {
        api = nil
        MockURLProtocol.requestHandler = nil
        cancellable?.cancel()
    }

    func testGetWeatherReturnsTemperatureWhenRequestSucceed() throws {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.baseUrl!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! Data(from: "weatherapi")
            return (response, data)
        }
        
        cancellable = api.getWeather(city: "gotham").sink { parameter in
            
            XCTAssertNotNil(parameter)
            XCTAssertEqual(parameter?.temp, 13.23)
        }
        
    }
    
    func testGetWeatherReturnsNilWhenRequestFails() throws {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: self.baseUrl!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        cancellable = api.getWeather(city: "gotham").sink { parameter in
            
            XCTAssertNil(parameter)
        }
        
    }

}
