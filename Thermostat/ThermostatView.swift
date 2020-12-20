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
            TemperatureDisplay(thermostat: thermostat)
            
            HStack {
                ControllsView(thermostat: thermostat)
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
