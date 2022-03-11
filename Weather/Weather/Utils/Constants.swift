//
//  Constants.swift
//  Weather
//
//  Created by jescobar on 3/3/22.
//

import Foundation

struct Constants {
    struct URLs {
        static func weather(for city: String) -> String {
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=1fcf7e692f7ff30868e654ef364a780b&units=metric"
        }
    }
}
