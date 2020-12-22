//
//  WeatherView.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 22/12/2020.
//

import SwiftUI

struct WeatherView: View {
    
    var temperature: Double?
    
    var body: some View {
        HStack {
            Text("London")
            Image(systemName: "thermometer.sun")
                .accessibility(hidden: true)
            if let temperature = temperature {
                Text(String(format: "%.1f ℃", temperature))
                    .accessibility(label: Text(String(format: "%.1f Centigrade", temperature)))

            } else {
                ProgressView()
            }
        }
    }
}
