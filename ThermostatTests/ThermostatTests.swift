//
//  ThermostatTests.swift
//  ThermostatTests
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Foundation
import XCTest
@testable import ThermostatApp

class ThermostatTests: XCTestCase {
    
    var thermostat: Thermostat!

    override func setUpWithError() throws {
        thermostat = Thermostat()
    }
    
    override func tearDownWithError() throws {
        thermostat = nil
    }

    func testIntialValueEqual20() {
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Thermostat.Constants.intialTemprature)
    }
    
    func testLowerTemperatureLowersTemperatureByOne(){
        
        let initalTemp = thermostat.temperature
        thermostat.lowerTemperature()
        
        let resultTemp = thermostat.temperature
        let differnce = initalTemp - resultTemp
        XCTAssertEqual(differnce, Thermostat.Constants.step)
    }
    
    func testMinimumTemeratureIsEqual10() {
        for _ in 0...105 {
            thermostat.lowerTemperature()
        }

        let result = thermostat.temperature
        
        XCTAssertEqual(result, Thermostat.Constants.minimumTemparture)
    }
    
    
}
