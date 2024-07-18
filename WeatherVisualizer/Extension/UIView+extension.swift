//
//  UIView+extension.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 18.07.2024.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            addSubview(view)
        }
    }
}
