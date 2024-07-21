//
//  RainViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

//MARK: - RainViewFactory
final class RainViewFactory: WeatherViewFactory {
    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .rain else { return nil }
        let rainView = RainView(frame: frame)
        rainView.setupView()
        rainView.startAnimation()
        return rainView
    }
}
