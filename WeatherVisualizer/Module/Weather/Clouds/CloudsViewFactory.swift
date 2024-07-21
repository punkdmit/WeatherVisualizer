//
//  CloudsViewFactory.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 21.07.2024.
//

import UIKit

//MARK: - CloudsViewFactory
final class CloudsViewFactory: WeatherViewFactory {

    override func createView(
        for weather: Weather,
        with frame: CGRect
    ) -> (any WeatherViewProtocol)? {
        guard weather == .clouds else { return nil }
        let cloudView = CloudsView(frame: frame)
        cloudView.setupView()
        cloudView.startAnimation()
        return cloudView
    }
}
