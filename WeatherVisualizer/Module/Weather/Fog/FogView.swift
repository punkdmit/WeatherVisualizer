//
//  FogView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 20.07.2024.
//

import UIKit

import UIKit

final class FogView: UIView {

    // MARK: Constants

    private enum Constants {
        static let fogImage = UIImage(named: "fog")
        static let numberOfFogImages = 5
        static let animationDuration: CFTimeInterval = 5
        static let keyframeAnimationPath = "position"
        static let fogAnimationKey = "fogAnimation"
        static let animationRange: CGFloat = 20
    }

    // MARK: UI Elements

    private lazy var fogImageViews: [UIImageView] = {
        var imageViews = [UIImageView]()
        for _ in 0..<Constants.numberOfFogImages {
            let imageView = UIImageView(image: Constants.fogImage)
            imageView.frame.size = CGSize(
                width: bounds.width,
                height: bounds.width
            )
            imageViews.append(imageView)
        }
        return imageViews
    }()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - WeatherViewProtocol
extension FogView: WeatherViewProtocol {

    func setupView() {
        setupUI()
        setupFogPositions()
    }

    func startAnimation() {
        for fogImageView in fogImageViews {
            animateFogImageView(fogImageView)
        }
    }
}

// MARK: - Private methods
private extension FogView {

    func setupUI() {
        backgroundColor = UIColor.clear
        configureLayout()
    }

    func configureLayout() {
        addSubviews(fogImageViews)
    }

    func setupFogPositions() {
        let positions = generateFixedPositions()
        for (index, fogImageView) in fogImageViews.enumerated() {
            fogImageView.frame.origin = positions[index]
        }
    }

    func generateFixedPositions() -> [CGPoint] {
        let width = bounds.width
        let height = bounds.height
        return [
            CGPoint(x: width * 0.2, y: height * 0.1),
            CGPoint(x: width * 0.1, y: height * 0.3),
            CGPoint(x: width * 0.7, y: height * 0.5),
            CGPoint(x: width * 0.6, y: height * 0.7),
            CGPoint(x: width * 0.9, y: height * 0.9)
        ]
    }

    func animateFogImageView(_ imageView: UIImageView) {
        let animation = CABasicAnimation(keyPath: Constants.keyframeAnimationPath)
        animation.duration = Constants.animationDuration
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let startX = imageView.frame.origin.x
        let startY = imageView.frame.origin.y
        let endX = startX + CGFloat.random(in: -Constants.animationRange...Constants.animationRange)
        let endY = startY + CGFloat.random(in: -Constants.animationRange...Constants.animationRange)

        ///ставим начальную и конечную позицию
        animation.fromValue = CGPoint(x: startX, y: startY)
        animation.toValue = CGPoint(x: endX, y: endY)

        imageView.layer.add(animation, forKey: Constants.fogAnimationKey)
    }
}
