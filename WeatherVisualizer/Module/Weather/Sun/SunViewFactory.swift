//
//  SunViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

//MARK: - SunViewFactory
final class SunViewFactory: WeatherViewFactory {

    override func createView(for weather: Weather) -> (any WeatherViewProtocol)? {
        guard weather == .sun else { return nil }
        let sunView = SunView(frame: AppConstants.screenSize)
        sunView.setupView()
        sunView.startAnimation()
        return sunView
    }
}
