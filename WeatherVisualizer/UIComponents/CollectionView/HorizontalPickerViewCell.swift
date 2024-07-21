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

//MARK: - Override methods
extension HorizontalPickerViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }
}

//MARK: - Internal methods
extension HorizontalPickerViewCell {

    func configure(with weather: Weather) { 
        titleLabel.text = weather.localized
    }
}

//MARK: - Private methods
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
        ? Assets.Colors.lime
        : Assets.Colors.dark

        titleLabel.textColor = isSelected
        ? Assets.Colors.dark
        : Assets.Colors.white

        layer.borderColor = Assets.Colors.dark.cgColor
    }
}
