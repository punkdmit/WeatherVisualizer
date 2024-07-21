//
//  FogViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

final class FogViewFactory: WeatherViewFactory {

    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .fog else { return nil }
        let fogView = FogView(frame: frame)
        fogView.setupView()
        fogView.startAnimation()
        return fogView
    }
}

