//
//  Data+Extension.swift
//  ThermostatAppTests
//
//  Created by Krzysztof Jankowski on 21/12/2020.
//

import Foundation

extension Data {
    
    init(from filename: String, extension type: String = "json") throws {
        let bundle = Bundle(for: Token.self)
        guard let url = bundle.url(forResource: filename, withExtension: type) else {
            throw NSError(domain: "tests", code: 1, userInfo: [:]) }
        self = try Data(contentsOf: url)
    }
}

fileprivate class Token {}
