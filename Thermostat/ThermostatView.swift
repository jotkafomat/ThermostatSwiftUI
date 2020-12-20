//
//  ThermostatView.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//

import SwiftUI

struct ThermostatView: View {
    
    @ObservedObject var thermostat: Thermostat
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f ℃", thermostat.temperature))
                .font(Font.system(.largeTitle,
                                  design: .monospaced))
                .bold()
                .foregroundColor(thermostat.energyUsage.color)
                .padding()
            HStack {
                Button(action: thermostat.lowerTemperature) {
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                }
                Button(action: thermostat.increaseTemperature) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
                Button(action: thermostat.resetTemperature) {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .imageScale(.large)
                }
                Button(action: { thermostat.isPowerSavingOn.toggle() } ) {
                    Image(systemName: "leaf.arrow.triangle.circlepath")
                        .imageScale(.large)
                        .foregroundColor(thermostat.isPowerSavingOn ? .green : .secondary )
                }
            }
        }
    }
}

struct ThermostatView_Previews: PreviewProvider {
    
    static var thermostat = Thermostat()
    
    static var previews: some View {
        ThermostatView(thermostat: thermostat)
    }
}
