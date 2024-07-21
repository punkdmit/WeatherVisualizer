//
//  WeatherViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

//MARK: - WeatherViewFactory
///родительский  класс
class WeatherViewFactory {

    ///абстрактный фабричный метод
    func createView(
        for weather: Weather,
        with frame: CGRect 
    ) -> (any WeatherViewProtocol)? {
        fatalError("Implement me")
    }
}
