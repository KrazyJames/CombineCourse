//
//  Weather.swift
//  Weather
//
//  Created by jescobar on 3/3/22.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
