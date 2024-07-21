//
//  WindViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 21.07.2024.
//

import UIKit

//MARK: - WindViewFactory
final class WindViewFactory: WeatherViewFactory {
    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .wind else { return nil }
        let windView = WindView(frame: frame)
        windView.setupView()
        windView.startAnimation()
        return windView
    }
}
