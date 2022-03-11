//
//  ViewController.swift
//  Weather
//
//  Created by jescobar on 3/3/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    private var webService = WeatherService()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPublishers()
//        cancellable = self.webService.fetchWeather(city: "Hermosillo")
//            .catch { _ in
//                Just(Weather.placeholder)
//            }
//            .map { weather in
//                if let temp = weather.temp {
//                    return "\(temp)°"
//                } else {
//                    return "Error getting weather"
//                }
//            }
//            .assign(to: \.text, on: self.label)
    }

    private func setUpPublishers() {
        let pub = NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
               object: self.textField
        )

        self.cancellable = pub.compactMap { notification in
            (notification.object as? UITextField)?
                .text?
                .addingPercentEncoding(
                    withAllowedCharacters: .urlPathAllowed
                )
        }
        .debounce(
            for: .milliseconds(500),
               scheduler: RunLoop.main
        )
        .flatMap { city in
            self.webService.fetchWeather(city: city)
                .catch { _ in Empty() }
                .map { $0 }
        }
        .sink { weather in
            self.label.text = "\(weather.temp)"
        }
    }

}

