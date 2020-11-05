//
//  Thermostat.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import Foundation

class Thermostat: ObservableObject {
    @Published private (set) var temperature: Double
    
    init() {
        temperature = Constants.intialTemprature
    }
    
    func lowerTemperature() {
        temperature = max(temperature - Constants.step, Constants.minimumTemparture)
    }
    
    struct Constants {
        static let intialTemprature = 20.0
        static let minimumTemparture = 10.0
        static let step = 1.0
    }
}
