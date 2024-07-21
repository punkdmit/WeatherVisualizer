//
//  String+extension.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 21.07.2024.
//

import Foundation

extension String {

    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main, 
            value: self,
            comment: self
        )
    }
}
