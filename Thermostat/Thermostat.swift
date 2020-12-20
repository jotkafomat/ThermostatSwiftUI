//
//  Thermostat.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Foundation

class Thermostat: ObservableObject {
    
    @Published private (set) var temperature: Double
    
    var isPowerSavingOn: Bool {
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
    
    struct Constants {
        static let intialTemprature = 20.0
        static let minimumTemparture = 10.0
        static let step = 1.0
        static let maximumTemperature = 32.0
        static let maximumTempPWSOn = 25.0
        static let lowEnergyUsageThreshold = 18.0
        static let highEnergyUsageThreshold = 25.0
    }

}

enum EnergyUsage {
    case low
    case medium
    case high
}
