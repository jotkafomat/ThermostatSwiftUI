//
//  ThermostatApp.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import SwiftUI

@main
struct ThermostatApp: App {
    
    var thermostat = Thermostat(weatherProvider: OpenWeatherAPI())
    
    var body: some Scene {
        WindowGroup {
            ThermostatView(thermostat: thermostat)
        }
    }
}
