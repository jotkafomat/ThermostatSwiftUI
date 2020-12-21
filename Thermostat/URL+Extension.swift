//
//  URL+Extension.swift
//  ThermostatApp
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import Foundation


extension URL {
    
    /// Appends `queryItems` to `URL`. In case of failure returns `self`
    func appending(_ queryItems: [URLQueryItem]) -> URL {
        guard !queryItems.isEmpty,
              var components = URLComponents(string: absoluteString) else {
            return self
        }
        var items = components.queryItems ?? []
        
        items.append(contentsOf: queryItems)
        components.queryItems = items
        return components.url ?? self
    }
}
