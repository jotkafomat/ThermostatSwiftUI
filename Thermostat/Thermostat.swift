//
//  Thermostat.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Foundation

class Thermostat: ObservableObject {
    
    @Published private (set) var temperature: Double
    
    @Published var isPowerSavingOn: Bool {
        didSet {
            if isPowerSavingOn {
                temperature = min(temperature, Constants.maximumTempPWSOn)
            }
        }
    }
    
    var energyUsage: EnergyUsage {
        if temperature < Constants.lowEnergyUsageThreshold {
            return .low
        } else if temperature > Constants.highEnergyUsageThreshold {
            return .high
        } else {
            return .medium
        }
    }
    
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
    
    func resetTemperature() {
        temperature = Constants.intialTemprature
    }

}
