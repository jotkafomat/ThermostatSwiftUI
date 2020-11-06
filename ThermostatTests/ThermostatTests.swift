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
    
    func testLowerTemperatureLowersTemperatureByOne() {
        
        let initalTemp = thermostat.temperature
        thermostat.lowerTemperature()
        
        let resultTemp = thermostat.temperature
        let differnce = initalTemp - resultTemp
        XCTAssertEqual(differnce, Thermostat.Constants.step)
    }
    
    func testMinimumTemeratureNeverFallsBellowMinimumTemperature() {
        for _ in 0...105 {
            thermostat.lowerTemperature()
        }

        let result = thermostat.temperature
        
        XCTAssertEqual(result, Thermostat.Constants.minimumTemparture)
    }
    
    func testIncreaseTemperatureByOne() {
        let initialTemp = thermostat.temperature
        
        thermostat.increaseTemperature()
        
        let resultTemp = thermostat.temperature
        
        let difference = resultTemp - initialTemp
        
        XCTAssertEqual(difference, Thermostat.Constants.step)
    }
    
    func testMaxTempNeverExeded() {
        thermostat.isPowerSavingOn = false
        
        for _ in 0...105 {
            thermostat.increaseTemperature()
        }
        
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Thermostat.Constants.maximumTemperature)
        
    }
    
    func testPowerSavingModeOnbyDefault() {
        let result = thermostat.isPowerSavingOn
        
        XCTAssertTrue(result)
    }
    //test_whenPowerSavingOn_TempratureSatysBelowPowerSavingMax
    func testTempWithPowerSavingModeOnNeverExedes() {
        //GIVEN power mode is on
        //WHEN I increase the temprature many times
        //THEN the tempearture never goes above power saving limit
        for _ in 0...105 {
            thermostat.increaseTemperature()
        }
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Thermostat.Constants.maximumTempPWSOn)
    }
}
