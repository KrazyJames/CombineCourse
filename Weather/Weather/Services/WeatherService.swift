//
//  WeatherService.swift
//  Weather
//
//  Created by jescobar on 3/3/22.
//

import Foundation
import Combine

class WeatherService {
    func fetchWeather(city: String) -> AnyPublisher<Weather, Error> {
        guard let url = URL(
            string: Constants.URLs.weather(
                for: city
            )
        ) else { fatalError("Invalid url") }

        return URLSession.shared.dataTaskPublisher(
            for: url
        )
        .map { $0.data }
        .decode(
            type: WeatherResponse.self,
            decoder: JSONDecoder()
        )
        .map { $0.main }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
