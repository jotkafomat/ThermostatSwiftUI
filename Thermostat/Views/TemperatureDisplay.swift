//
//  TemperatureDisplay.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 20/12/2020.
//

import SwiftUI

struct TemperatureDisplay: View {
    
    @ObservedObject var thermostat: Thermostat
    
    var body: some View {
        Text(String(format: "%.1f ℃", thermostat.temperature))
            .font(Font.system(.largeTitle,
                              design: .monospaced))
            .bold()
            .foregroundColor(thermostat.energyUsage.color)
            .padding()
            .accessibility(label: Text(String(format: "%.1f Centigrade", thermostat.temperature)))
            .accessibility(identifier: "temperature display")

        }
}
