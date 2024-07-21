//
//  HorizontalPickerView.swift
//  WeatherVisualizer
//
//  Created by Dmitry Apenko on 18.07.2024.
//

import UIKit

final class HorizontalPickerView: UIView {

    // MARK: Constants

    private enum Constants {
        static let collectionViewWidthMultiplier = 0.1
    }

    //MARK: Weak properties

    weak var delegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }

    weak var dataSource: UICollectionViewDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }

    //MARK: Private properties

    private var selectedCellIndexPath: IndexPath?

    //MARK: UI Elements

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HorizontalPickerViewCell.self, forCellWithReuseIdentifier: HorizontalPickerViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal methods
extension HorizontalPickerView {
    
    func select(
        row: Int,
        data: [Weather],
        in section: Int = 0,
        animated: Bool = true,
        isFirstLaunch: Bool = false
    ) {
        guard row < data.count else { return }
        let indexPath = IndexPath(row: row, section: section)
        selectedCellIndexPath = indexPath
        collectionView.selectItem(
            at: indexPath,
            animated: animated,
            scrollPosition: .centeredHorizontally
        )
        if isFirstLaunch {
            delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
        }
    }

    func selectRandom(
        row: Int,
        section: Int = 0
    ) {
        let indexPath = IndexPath(row: row, section: section)
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}

//MARK: - Private methods
private extension HorizontalPickerView {

    func setupUI() {
        collectionView.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: bounds.width),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: Constants.collectionViewWidthMultiplier),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: AppConstants.compactSpacing),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

