//
//  RainView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

final class RainView: UIView {

    // MARK: Constants

    private enum Constants {
        static let rainImage = UIImage(named: "raindrop")
        static let rainCellScale = 0.1
        static let rainCellBirthRate: Float = 25
        static let rainCellLifeTime: Float = 5.0
        static let rainCellVelocity: CGFloat = 300
        static let rainCellVelocityRange: CGFloat = 100
        static let rainCellAcceleration: CGFloat = 300
        static let rainCellAlphaRange: Float = 0.5
        static let rainCellAlphaSpeed: Float = -0.1
    }

    //MARK: Private properties

    private let rainLayer = CAEmitterLayer()
    private let rainCell = CAEmitterCell()

    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - WeatherViewProtocol
extension RainView: WeatherViewProtocol {

    func setupView() {
        setupUI()
        setupRainLayer()
        setupRainCell()
    }

    func startAnimation() {
        layer.addSublayer(rainLayer)
    }
}

//MARK: - Private methods
private extension RainView {

    func setupUI() {
        backgroundColor = Assets.Colors.grayLight
    }

    func setupRainLayer() {
        ///позиция
        rainLayer.emitterPosition = CGPoint(
            x: bounds.width / 2,
            y: -bounds.width
        )
        ///размер
        rainLayer.emitterSize = CGSize(
            width: bounds.width,
            height: 0
        )
        ///форма
        rainLayer.emitterShape = .line
        rainLayer.emitterCells = [rainCell]
    }

    func setupRainCell() {
        guard let rainImage = Constants.rainImage else { return }
        rainCell.contents = rainImage.cgImage
        rainCell.scale = Constants.rainCellScale
        ///частота появления
        rainCell.birthRate = Constants.rainCellBirthRate
        rainCell.lifetime = Constants.rainCellLifeTime
        ///скорость
        rainCell.velocity = Constants.rainCellVelocity
        ///диапазон скорости
        rainCell.velocityRange = Constants.rainCellVelocityRange
        ///ускорение
        rainCell.yAcceleration = Constants.rainCellAcceleration
        ///диапазон прозрачности
        rainCell.alphaRange = Constants.rainCellAlphaRange
        ///скорость изменения прозрачности
        rainCell.alphaSpeed = Constants.rainCellAlphaSpeed
    }
}
