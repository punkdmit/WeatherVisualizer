//
//  ThunderstormViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 22.07.2024.
//

import UIKit

// MARK: - ThunderstormViewFactory
final class ThunderstormViewFactory: WeatherViewFactory {

    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .thunderstorm else { return nil }
        let thunderstormView = ThunderstormView(frame: frame)
        thunderstormView.setupView()
        thunderstormView.startAnimation()
        return thunderstormView
    }
}

