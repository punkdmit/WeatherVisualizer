//
//  SunViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

//MARK: - SunViewFactory
final class SunViewFactory: WeatherViewFactory {

    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .sun else { return nil }
        let sunView = SunView(frame: frame)
        sunView.setupView()
        sunView.startAnimation()
        return sunView
    }
}
