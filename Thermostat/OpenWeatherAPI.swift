//
//  OpenWeatherAPI.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import Foundation
import Combine

protocol WeatherProvider {
    func getWeather(city: String) -> AnyPublisher<WeatherParameters?, Never>
}

class OpenWeatherAPI: WeatherProvider {
    
    private let session: URLSession
    private let baseUrl: URL
    private static let key = "e7a4418a4fdf0beb9a4ecd169f0ff00a"
    
    public init(session: URLSession = URLSession.shared, baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!) {
        self.session = session
        self.baseUrl = baseUrl
    }
    
    func getWeather(city: String) -> AnyPublisher<WeatherParameters?, Never> {
        let querryItems = [URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
                           URLQueryItem(name: "q", value: city),
                           URLQueryItem(name: "units", value: "metric")]
        let url = baseUrl.appending(querryItems)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { $0.main }
            .catch { _ in Just<WeatherParameters?>(nil)}
            .eraseToAnyPublisher()
    }
    
    
}
