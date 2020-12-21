//
//  ThermostatTests.swift
//  ThermostatTests
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Combine
import Foundation
import XCTest
@testable import ThermostatApp

class ThermostatTests: XCTestCase {
    
    var thermostat: Thermostat!
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        
        thermostat = Thermostat(weatherProvider: MockWeatherProvider.succesful)
    }
    
    override func tearDownWithError() throws {
        thermostat = nil
        cancellable?.cancel()
    }

    func testIntialValueEqual20() {
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Constants.intialTemprature)
    }
    
    func testLowerTemperatureLowersTemperatureByOne() {
        
        let initalTemp = thermostat.temperature
        thermostat.lowerTemperature()
        
        let resultTemp = thermostat.temperature
        let differnce = initalTemp - resultTemp
        XCTAssertEqual(differnce, Constants.step)
    }
    
    func testMinimumTemeratureNeverFallsBellowMinimumTemperature() {
        for _ in 0...105 {
            thermostat.lowerTemperature()
        }

        let result = thermostat.temperature
        
        XCTAssertEqual(result, Constants.minimumTemparture)
    }
    
    func testIncreaseTemperatureByOne() {
        let initialTemp = thermostat.temperature
        
        thermostat.increaseTemperature()
        
        let resultTemp = thermostat.temperature
        
        let difference = resultTemp - initialTemp
        
        XCTAssertEqual(difference, Constants.step)
    }
    
    func testMaxTempNeverExeded() {
        thermostat.isPowerSavingOn = false
        
        for _ in 0...105 {
            thermostat.increaseTemperature()
        }
        
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Constants.maximumTemperature)
        
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
        
        XCTAssertEqual(result, Constants.maximumTempPWSOn)
    }
    
    func testResetTemperatureSetTemperatureBackToInitial() {
        
        for _ in 0...105 {
            thermostat.increaseTemperature()
        }
        thermostat.resetTemperature()
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Constants.intialTemprature)
    }
    
    func testEnergyUsageLow() {
        
        for _ in 0...3 {
            thermostat.lowerTemperature()
        }
        
        let result = thermostat.energyUsage
        XCTAssertEqual(result, .low)
    }
    
    func testEnergyUsageMedium() {
        
        let result = thermostat.energyUsage
        XCTAssertEqual(result, .medium)
    }
    
    func testEnergyUsageHigh() {
        thermostat.isPowerSavingOn = false
        for _ in 0...8 {
            thermostat.increaseTemperature()
        }
        
        let result = thermostat.energyUsage

        XCTAssertEqual(result, .high)
    }
    
    func testShowKa() {
        thermostat.isPowerSavingOn = false
        for _ in 0...8 {
            thermostat.increaseTemperature()
        }
        thermostat.isPowerSavingOn = true
        let result = thermostat.temperature
        
        XCTAssertEqual(result, Constants.maximumTempPWSOn)
    }
    
    func testWeatherProviderSucceess() {
        
        let thermostat = Thermostat(weatherProvider: MockWeatherProvider.succesful)
        let expectation = XCTestExpectation(description: "expect outside temp not be nil")
        
        cancellable = thermostat
            .$outsideTemperature
            .dropFirst()
            .sink { temp in
            
            XCTAssertNotNil(temp)
            XCTAssertEqual(temp, 13.23)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testWeatherProviderFailure() {
        
        let thermostat = Thermostat(weatherProvider: MockWeatherProvider.errorProne)
        let expectation = XCTestExpectation(description: "expect outside temp to be nil")
        
        cancellable = thermostat
            .$outsideTemperature
            .dropFirst()
            .sink { temp in
            
            XCTAssertNil(temp)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

