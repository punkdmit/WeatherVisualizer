//
//  CloudsView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 21.07.2024.
//

import UIKit

final class CloudsView: UIView {

    // MARK: Constants

    private enum Constants {
        static let cloudImage = UIImage(named: "cloud")
        static let numberOfCloudImages = 9
        static let animationDuration: CFTimeInterval = 10
        static let keyframeAnimationPath = "position"
        static let fogAnimationKey = "cloudAnimation"
        static let animationRange: CGFloat = 20
    }

    // MARK: UI Elements

    private lazy var cloudImageViews: [UIImageView] = {
        var imageViews = [UIImageView]()
        for _ in 0..<Constants.numberOfCloudImages {
            let imageView = UIImageView(image: Constants.cloudImage)
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
extension CloudsView: WeatherViewProtocol {

    func setupView() {
        setupUI()
        setupFogPositions()
        setupFogSize()
    }

    func startAnimation() {
        for cloudImageView in cloudImageViews {
            animateCloudImageView(cloudImageView)
        }
    }
}

// MARK: - Private methods
private extension CloudsView {

    func setupUI() {
        backgroundColor = Assets.Colors.blue
        configureLayout()
    }

    func configureLayout() {
        addSubviews(cloudImageViews)
    }

    func setupFogSize() {
        for imageView in cloudImageViews {
            let aspectRatio = imageView.frame.width / imageView.frame.height
            let width = bounds.width
            let height = width / aspectRatio
            imageView.frame.size = CGSize(
                width: width,
                height: height
            )
        }
    }

    func setupFogPositions() {
        let positions = generateFixedPositions()
        guard positions.count <= cloudImageViews.count else { return }
        for (index, fogImageView) in cloudImageViews.enumerated() {
            fogImageView.frame.origin = positions[index]
        }
    }

    func generateFixedPositions() -> [CGPoint] {
        let width = bounds.width
        let height = bounds.height
        return [
            CGPoint(x: width * 0.2, y: height * 0.1),
            CGPoint(x: width * 0.1, y: height * 0.3),
            CGPoint(x: width * 0.3, y: height * 0.2),
            CGPoint(x: width * 0.7, y: height * 0.3),
            CGPoint(x: width * 0.1, y: height * 0.1),
            CGPoint(x: width * 0.9, y: height * 0.2),
            CGPoint(x: width, y: height * 0.3),
            CGPoint(x: width, y: height * 0.2),
            CGPoint(x: width * 0.6, y: height * 0.1)
        ]
    }

    func animateCloudImageView(_ imageView: UIImageView) {
        let animation = CABasicAnimation(keyPath: Constants.keyframeAnimationPath)
        animation.duration = Constants.animationDuration
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let startX = imageView.frame.origin.x
        let startY = imageView.frame.origin.y
        let endX = startX + CGFloat.random(in: -Constants.animationRange...Constants.animationRange)
        let endY = startY + CGFloat.random(in: -Constants.animationRange...Constants.animationRange)
        animation.fromValue = CGPoint(x: startX, y: startY)
        animation.toValue = CGPoint(x: endX, y: endY)
        imageView.layer.add(animation, forKey: Constants.fogAnimationKey)
    }
}

