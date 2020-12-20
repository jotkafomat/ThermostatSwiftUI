//
//  EnergyUsage.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 20/12/2020.
//

import SwiftUI

enum EnergyUsage {
    case low
    case medium
    case high
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .primary
        case .high:
            return .red
        }
    }
}

