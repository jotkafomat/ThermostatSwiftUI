//
//  ThermostatUITests.swift
//  ThermostatUITests
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import XCTest

@testable import ThermostatApp

class ThermostatUITests: XCTestCase {
    
    var app: XCUIApplication!
    var temperatureDisplay: String {
        app.staticTexts["temperature display"].label
    }
    
    var plusButton: XCUIElement {
        app.buttons["plus button"]
    }
    
    var minusButton: XCUIElement {
        app.buttons["minus button"]
    }
    
    var resetButton: XCUIElement {
        app.buttons["reset button"]
    }
    
    var powerSavingButton: XCUIElement {
        app.buttons["power saving button"]
    }
    
    var cityName: XCUIElement {
        app.staticTexts["city name"]
    }
    
    var cityTemperature: XCUIElement {
        app.staticTexts["city temperature"]
    }
    
    var searchField: XCUIElement {
        app.textFields["city"]
    }
    
    var searchButton: XCUIElement {
        app.buttons["search"]
    }
    

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    func testDefaultTemperature() throws {
        //WHEN I first open the app
        //THEN the temparture is 20
        let temp = Constants.intialTemprature
        
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testIncreaseTemperature() {
        //GIVEN the temparture is 20
        //WHEN I tap on plus button
        plusButton.tap()
        //THEN the temparture increses by 1
        let temp = Constants.intialTemprature + Constants.step
        
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testLowerTemperature() {
        //GIVEN the temparture is 20
        //WHEN I tap on minus button
        minusButton.tap()
        //THEN the temparture decreases by 1
        let temp = Constants.intialTemprature - Constants.step
        
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testResetTemperature() {
        //GIVEN the temparture is 20
        //WHEN I tap on minus button twice
        //AND I tap on the reset button
        minusButton.tap()
        minusButton.tap()
        resetButton.tap()
        //THEN the temparture is still 20
        let temp = Constants.intialTemprature
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testPowerSavingOn() {
        //GIVEN the temparture is 20
        //WHEN I repeatedly tap on plus button
        for _ in 0...10 {
            plusButton.tap()
        }
        //THEN The temprature only reaches 25
        let temp = Constants.maximumTempPWSOn
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testPowerSavingOff() {
        //GIVEN the temparture is 20
        //WHEN I turn power seaver off
        powerSavingButton.tap()
        //AND I repeatedly tap on plus button
        for _ in 0...20 {
            plusButton.tap()
        }
        //THEN The temprature only reaches 32
        let temp = Constants.maximumTemperature
        
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testSwitchingPowerSavingOnLowersTemperature() {
        //GIVEN the temparture is 20
        //WHEN I turn power seaver off
        powerSavingButton.tap()
        //AND I repeatedly tap on plus button
        for _ in 0...20 {
            plusButton.tap()
        }
        //AND I turn on power saving
        powerSavingButton.tap()
        
        //THEN The temprature resets to 25
        let temp = Constants.maximumTempPWSOn
        
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testMinimumTemperature() {
        //GIVEN the temparture is 20
        //WHEN I repeatedly tap on plus button
        for _ in 0...15 {
            minusButton.tap()
        }
        //THEN The temprature only falls to 10
        let temp = Constants.minimumTemparture
        XCTAssertEqual(temperatureDisplay, String(format: "%.1f Centigrade", temp))
    }
    
    func testDisplayCityName() {
        XCTAssert(cityName.exists)
    }
    
    func testDisplayCityTemperature() {
        searchField.tap()
        searchField.typeText("London")
        searchButton.tap()
        XCTAssert(cityTemperature.waitForExistence(timeout: 2.0))
    }

}
