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
            
            ControllsView(thermostat: thermostat)
            WeatherView(action: thermostat.getTemp,
                        temperature: thermostat.outsideTemperature,
                        city: $thermostat.city)
            
            
        }
    }
}

struct ThermostatView_Previews: PreviewProvider {
    
    static var thermostat = Thermostat(weatherProvider: OpenWeatherAPI())
    
    static var previews: some View {
        ThermostatView(thermostat: thermostat)
    }
}
