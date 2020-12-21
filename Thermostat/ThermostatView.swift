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
            WeatherView(temperature: thermostat.outsideTemperature)
            
            
        }
    }
}

struct WeatherView: View {
    
    var temperature: Double?
    
    var body: some View {
        HStack {
            Text("London")
            Image(systemName: "thermometer.sun")
            if let temperature = temperature {
                Text(String(format: "%.1f ℃", temperature))
            } else {
                ProgressView()
            }
        }
    }
}

struct ThermostatView_Previews: PreviewProvider {
    
    static var thermostat = Thermostat(weatherProvider: OpenWeatherAPI())
    
    static var previews: some View {
        ThermostatView(thermostat: thermostat)
    }
}
