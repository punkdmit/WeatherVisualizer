//
//  SunView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

final class SunView: UIView {

    // MARK: Constants

    private enum Constants {
        static let sunImage = UIImage(named: "sunImage")
        static let sunImageCGPoint = CGPoint(x: 0, y: 0)
        static let animationDuration: CFTimeInterval = 5
        static let startAngle: CGFloat = 1.5 * .pi
        static let endAngle: CGFloat = 3.5 * .pi
        static let keyframeAnimationPath = "position"
        static let sunAnimationKey = "sunAnimation"
    }

    //MARK: UI Elements

    private lazy var sunImageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.sunImage
        image.frame = CGRect(
            x: Constants.sunImageCGPoint.x,
            y: Constants.sunImageCGPoint.y,
            width: bounds.width,
            height: bounds.width
        )
        return image
    }()

    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - WeatherViewProtocol
extension SunView: WeatherViewProtocol {

    func setupView() {
        setupUI()
    }

    func startAnimation() {
        let path = UIBezierPath()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height) / 4

        ///круговая траектория
        path.addArc(
            withCenter: center,
            radius: radius,
            startAngle: Constants.startAngle,
            endAngle: Constants.endAngle,
            clockwise: true
        )

        /// Анимация
        let animation = CAKeyframeAnimation(keyPath: Constants.keyframeAnimationPath)
        animation.path = path.cgPath
        animation.duration = Constants.animationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        sunImageView.layer.add(animation, forKey: Constants.sunAnimationKey)
    }

}

//MARK: - Private methods
private extension SunView {

    func setupUI() {
        backgroundColor = Assets.Colors.blueLight
        configureLayout()
    }

    func configureLayout() {
        addSubview(sunImageView)
    }
}
