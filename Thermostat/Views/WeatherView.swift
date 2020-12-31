//
//  WeatherView.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 22/12/2020.
//

import SwiftUI

struct WeatherView: View {
    
    var action: () -> Void
    var temperature: Double?
    @Binding var city: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("city", text: $city)
                    .accessibilityLabel("find city")
                Button(action: action, label: {
                    Image(systemName: "magnifyingglass.circle")
                })
                .accessibilityLabel("search")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white).shadow(color: .gray, radius: 5))
            HStack {
                Text(city)
                    .accessibility(identifier: "city name")

                Image(systemName: "thermometer.sun")
                    .accessibility(hidden: true)
                if let temperature = temperature {
                    Text(String(format: "%.1f ℃", temperature))
                        .accessibility(label: Text(String(format: "%.1f Centigrade", temperature)))
                        .accessibility(identifier: "city temperature")

                } else {
                    ProgressView()
                }
            }
        }
        .padding(.horizontal, 50.0)
    }
}
