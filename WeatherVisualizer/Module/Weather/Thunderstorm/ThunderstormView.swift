//
//  ThunderstormView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 22.07.2024.
//

import UIKit

final class ThunderstormView: UIView {

    // MARK: Constants

    private enum Constants {
        static let thunderstormImage = UIImage(named: "thunderstorm")
        static let defaultAlpha: CGFloat = 0
        static let endAlpha: CGFloat = 1
        static let animationDuration: TimeInterval = 2
        static let timeInterval: TimeInterval = 3
    }

    // MARK: Private properties

    private var timer: Timer?

    // MARK: UI Elements

    private lazy var thunderstormImageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.thunderstormImage
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: - Internal methods
extension ThunderstormView: WeatherViewProtocol {

    func setupView() {
        backgroundColor = Assets.Colors.dark
        setupUI()
    }
    
    func startAnimation() {
        timer = Timer.scheduledTimer(
            timeInterval: Constants.timeInterval,
            target: self,
            selector: #selector(showThunderstorm),
            userInfo: nil,
            repeats: true
        )
    }
}

// MARK: - Objc methods
@objc
extension ThunderstormView {

    private func showThunderstorm() {
        thunderstormImageView.alpha = Constants.endAlpha
        UIView.animate(withDuration: Constants.animationDuration) {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.thunderstormImageView.alpha = Constants.defaultAlpha
            }
        }
    }
}

// MARK: - Private methods
private extension ThunderstormView {

    func setupUI() {
        configureLayout()
    }

    func configureLayout() {
        addSubview(thunderstormImageView)
        thunderstormImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            thunderstormImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thunderstormImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thunderstormImageView.topAnchor.constraint(equalTo: topAnchor),
            thunderstormImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
