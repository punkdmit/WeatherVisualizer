//
//  HorizontalPickerViewCell.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 18.07.2024.
//

import Foundation
import UIKit

final class HorizontalPickerViewCell: UICollectionViewCell {

    // MARK: Constants

    private enum Constants {
        static let borderWidth = 1.0
    }

    static var identifier: String { "\(Self.self)" }

    // MARK: Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = SemiboldFont.h2
        label.textAlignment = .center
        return label
    }()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override var isSelected: Bool {
        didSet {
            setupCell()
        }
    }

}

extension HorizontalPickerViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }
}

extension HorizontalPickerViewCell {

    func configure(with weather: Weather) { //naming
        titleLabel.text = weather.rawValue
    }
}

private extension HorizontalPickerViewCell {

    func setupUI() {
        self.layer.borderWidth = Constants.borderWidth
        setupCell()
        configureLayout()
    }

    private func configureLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupCell() {
        backgroundColor = isSelected
        ? Assets.Colors.dark
        : Assets.Colors.grayLight

        layer.borderColor = isSelected
        ? Assets.Colors.grayLight.cgColor
        : Assets.Colors.dark.cgColor

        titleLabel.textColor = isSelected
        ? Assets.Colors.grayLight
        : Assets.Colors.dark
    }

//    func makeShadow() {
//        containingView.backgroundColor = Assets.Colors.background
//        containingView.layer.shadowColor = Assets.Colors.grayIcon.cgColor
//        containingView.layer.shadowOffset = Constants.shadowOffset
//        containingView.layer.shadowOpacity = Constants.shadowOpacity
//        containingView.layer.shadowRadius = Constants.shadowRadius
//        containingView.layer.cornerRadius = Constants.cornerRadius
//        containingView.layer.masksToBounds = false
//    }
}
