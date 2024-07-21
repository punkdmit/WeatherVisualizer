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

    //MARK: Private properties

    private var weatherViewFactory: WeatherViewFactory?

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectRandomWeather()
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

        switch selectedWeather {
        case .rain:
            weatherViewFactory = RainViewFactory()
        case .fog:
            weatherViewFactory = FogViewFactory()
        case .sun:
            weatherViewFactory = SunViewFactory()
        case .thunderstorm:
            weatherViewFactory = RainViewFactory()
        case .wind:
            weatherViewFactory = WindViewFactory()
        case .clouds:
            weatherViewFactory = CloudsViewFactory()
        }
        let newView = weatherViewFactory?.createView(
            for: selectedWeather,
            with: AppConstants.screenSize
        ) as? UIView

        if let newView {
            addSubviewWithFade(newView)
        }
    }
}

//MARK: - Animation
private extension WeatherViewController {

    func addSubviewWithFade(
        _ newView: UIView,
        duration: TimeInterval = 1
    ) {
        newView.alpha = 0
        view.insertSubview(newView, belowSubview: horizontalPickerView)

        if let oldView = view.subviews.first(where: { $0 != newView && $0 != horizontalPickerView }) {
            UIView.animate(withDuration: duration, animations: {
                oldView.alpha = 0
            }, completion: { _ in
                oldView.removeFromSuperview()
            })
        }

        UIView.animate(withDuration: duration, animations: {
            newView.alpha = 1
        })
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

    func selectRandomWeather() {
        let randomIndex = Int.random(in: 0..<Weather.allCases.count)
        horizontalPickerView.selectRandom(row: randomIndex)
    }

    func removePreviousSubview() {
        view.subviews.forEach {
            if $0 !== horizontalPickerView {
                $0.removeFromSuperview()
            }
        }
    }
}

