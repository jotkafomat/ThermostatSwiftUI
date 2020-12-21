//
//  WeatherResponse.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: WeatherParameters
}


struct WeatherParameters: Decodable {
    let temp: Double
}
