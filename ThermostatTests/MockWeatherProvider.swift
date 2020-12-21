//
//  MockWeatherProvider.swift
//  ThermostatAppTests
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import Foundation
@testable import ThermostatApp
import Combine


enum MockWeatherProvider: WeatherProvider {
    
    case errorProne
    case succesful
    
    func getWeather(city: String) -> AnyPublisher<WeatherParameters?, Never> {
        switch self {
        case .errorProne:
            return Just<WeatherParameters?>(nil).eraseToAnyPublisher()
        case .succesful:
            let data = try? Data(from: "weatherapi")
            let response = try? JSONDecoder().decode(WeatherResponse.self, from: data!)
            return Just<WeatherParameters?>(response?.main).eraseToAnyPublisher()
        }
    }
    
}
