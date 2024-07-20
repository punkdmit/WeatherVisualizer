//
//  ViewController.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 18.07.2024.
//

import UIKit

class HorizontalPickerViewController: UIViewController {

    // MARK: Constants

    private enum Constants {
        static let weatherArray = ["Туман", "Солнце", "Дождь", "Гроза", "Ветер", "Облачно"]
    }

    // MARK: Private properties

    private var data: [String] = []

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
        setUpData()

    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HorizontalPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HorizontalPickerViewCell.identifier,
            for: indexPath
        ) as? HorizontalPickerViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.row])
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
        horizontalPickerView.select(row: indexPath.row, data: data)
    }
}

//MARK: - Private methods
private extension HorizontalPickerViewController {

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

    func setUpData() {
        for value in Constants.weatherArray {
            data.append(value)
        }
    }
}

