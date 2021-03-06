//
//  Thermostat.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 05/11/2020.
//
import Combine
import Foundation

class Thermostat: ObservableObject {
    
    @Published private (set) var temperature: Double
    @Published private (set) var outsideTemperature: Double?
    
    @Published var isPowerSavingOn: Bool {
        didSet {
            if isPowerSavingOn {
                temperature = min(temperature, Constants.maximumTempPWSOn)
            }
        }
    }
    private let weatherProvider: WeatherProvider
    var city: String = ""
    
    var energyUsage: EnergyUsage {
        if temperature < Constants.lowEnergyUsageThreshold {
            return .low
        } else if temperature > Constants.highEnergyUsageThreshold {
            return .high
        }
        return .medium
    }
    
    init(weatherProvider: WeatherProvider) {
        temperature = Constants.intialTemprature
        isPowerSavingOn = true
        self.weatherProvider = weatherProvider
    }
    
    func getTemp() {
        weatherProvider
            .getWeather(city: city)
            .receive(on: RunLoop.main)
            .map { $0?.temp }
            .assign(to: &$outsideTemperature)
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
