//
//  ControllsView.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 20/12/2020.
//

import SwiftUI

struct ControllsView: View {
    
    @ObservedObject var thermostat: Thermostat
    
    var body: some View {
        HStack {
            
            Button(action: thermostat.lowerTemperature) {
                Image(systemName: "minus.circle")
                    .imageScale(.large)
            }
            .accessibility(identifier: "minus button")
            .accessibility(label: Text("decrease temperature"))
            
            Button(action: thermostat.increaseTemperature) {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }
            .accessibility(identifier: "plus button")
            .accessibility(label: Text("increase temperature"))
            
            Button(action: thermostat.resetTemperature) {
                Image(systemName: "arrow.counterclockwise.circle")
                    .imageScale(.large)
            }
            .accessibility(identifier: "reset button")
            .accessibility(label: Text("reset temperature"))
            
            Button(action: { thermostat.isPowerSavingOn.toggle() } ) {
                Image(systemName: "leaf.arrow.triangle.circlepath")
                    .imageScale(.large)
                    .foregroundColor(thermostat.isPowerSavingOn ? .green : .secondary )
            }
            .accessibility(identifier: "power saving button")
            .accessibility(label: Text("power saving mode toggle \(thermostat.isPowerSavingOn ? "on" : "off")"))
        }
    }
}
