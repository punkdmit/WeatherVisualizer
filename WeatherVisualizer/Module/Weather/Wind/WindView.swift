//
//  WindView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 21.07.2024.
//

import UIKit

final class WindView: UIView {

    // MARK: Constants

    private enum Constants {
        static let windImage = UIImage(named: "wind")
        static let windCellScale: CGFloat = 0.6
        static let windCellBirthRate: Float = 2
        static let windCellLifeTime: Float = 10
        static let windCellVelocity: CGFloat = 300
        static let windCellVelocityRange: CGFloat = 100
        static let windCellAcceleration: CGFloat = 50
        static let windCellAlphaRange: Float = 0.5
        static let windCellAlphaSpeed: Float = -0.1
        static let windEmissionLongitude: CGFloat = .pi / 3
    }

    //MARK: Private properties

    private let windLayer = CAEmitterLayer()
    private let windCell = CAEmitterCell()

    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - WeatherViewProtocol
extension WindView: WeatherViewProtocol {

    func setupView() {
        setupUI()
        setupWindLayer()
        setupWindCell()
    }

    func startAnimation() {
        layer.addSublayer(windLayer)
    }
}

//MARK: - Private methods
private extension WindView {

    func setupUI() {
        backgroundColor = Assets.Colors.yellow
    }

    private func setupWindLayer() {
        windLayer.emitterPosition = CGPoint(
            x: -bounds.width,
            y: bounds.height / 1.5
        )
        windLayer.emitterSize = CGSize(
            width: bounds.height,
            height: 0
        )
        windLayer.emitterShape = .line
        windLayer.emitterCells = [windCell] 
    }

    private func setupWindCell() {
        guard let windImage = Constants.windImage else { return }
        windCell.contents = windImage.cgImage
        windCell.scale = Constants.windCellScale
        windCell.birthRate = Constants.windCellBirthRate
        windCell.lifetime = Constants.windCellLifeTime
        windCell.velocity = Constants.windCellVelocity
        windCell.velocityRange = Constants.windCellVelocityRange
        windCell.xAcceleration = Constants.windCellAcceleration
        windCell.alphaRange = Constants.windCellAlphaRange
        windCell.alphaSpeed = Constants.windCellAlphaSpeed
        windCell.emissionLongitude = Constants.windEmissionLongitude
    }
}
