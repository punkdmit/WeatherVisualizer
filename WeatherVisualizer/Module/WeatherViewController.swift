//
//  WeatherViewController.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 18.07.2024.
//

import UIKit

enum Weather: String, CaseIterable {
    case fog = "Туман"
    case sun = "Солнце"
    case rain = "Дождь"
    case thunderstorm = "Гроза"
    case wind = "Ветер"
    case clouds = "Облака"
}

class WeatherViewController: UIViewController {

    // MARK: Constants

    private enum Constants { }

    // MARK: UI Elements

    private lazy var horizontalPickerView: HorizontalPickerView = {
        let pickerView = HorizontalPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Weather.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HorizontalPickerViewCell.identifier,
            for: indexPath
        ) as? HorizontalPickerViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: Weather.allCases[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: view.bounds.width / 4,
            height: view.bounds.height
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        AppConstants.compactSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        horizontalPickerView.select(row: indexPath.row, data: Weather.allCases)
        let selectedWeather = Weather.allCases[indexPath.row]

        let factory: WeatherViewFactory?
        switch selectedWeather {
        case .rain:
            factory = RainViewFactory()
        case .fog:
            factory = FogViewFactory()
        case .sun:
            factory = SunViewFactory()
        case .thunderstorm:
            factory = RainViewFactory()
        case .wind:
            factory = RainViewFactory()
        case .clouds:
            factory = RainViewFactory()
        }

        view.subviews.forEach {
            if $0 !== horizontalPickerView {
                $0.removeFromSuperview()
            }
        }

        let newView = factory?.createView(for: selectedWeather) as? UIView
        if let newView {
            view.insertSubview(newView, belowSubview: horizontalPickerView)
        }
    }
}

//MARK: - Private methods
private extension WeatherViewController {

    func setupUI() {
        view.backgroundColor = Assets.Colors.white
        configureLayout()
    }

    func configureLayout() {
        view.addSubview(horizontalPickerView)
        horizontalPickerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalPickerView.topAnchor.constraint(equalTo: view.topAnchor),
            horizontalPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            horizontalPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

