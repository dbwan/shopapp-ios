//
//  GridCollectionProvider.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 1/31/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import UIKit

private let kGridNumberOfColumns: CGFloat = 2
private let kCellImageRatio: CGFloat = 16 / 9

@objc protocol GridCollectionProviderDelegate: class {
    func provider(_ provider: GridCollectionProvider, didSelect product: Product)
    @objc optional func provider(_ provider: GridCollectionProvider, didScroll scrollView: UIScrollView)
}

class GridCollectionProvider: NSObject {
    var products: [Product] = []
    
    weak var delegate: GridCollectionProviderDelegate?
}

// MARK: - UICollectionViewDataSource

extension GridCollectionProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GridCollectionViewCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
        let product = products[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GridCollectionProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        let product = products[indexPath.row]
        delegate.provider(self, didSelect: product)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.provider?(self, didScroll: scrollView)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GridCollectionProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GridCollectionViewCell.cellSize
    }
}