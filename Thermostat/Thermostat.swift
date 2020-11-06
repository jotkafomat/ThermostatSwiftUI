//
//  Thermostat.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Foundation

class Thermostat: ObservableObject {
    @Published private (set) var temperature: Double
    var isPowerSavingOn: Bool
    
    init() {
        temperature = Constants.intialTemprature
        isPowerSavingOn = true
    }
    
    func lowerTemperature() {
        temperature = max(temperature - Constants.step, Constants.minimumTemparture)
    }
    func increaseTemperature() {
        
        let maxTemp = isPowerSavingOn ? Constants.maximumTempPWSOn : Constants.maximumTemperature
        temperature = min(temperature + Constants.step, maxTemp)
    }
    
    struct Constants {
        static let intialTemprature = 20.0
        static let minimumTemparture = 10.0
        static let step = 1.0
        static let maximumTemperature = 32.0
        static let maximumTempPWSOn = 25.0
    }
}
