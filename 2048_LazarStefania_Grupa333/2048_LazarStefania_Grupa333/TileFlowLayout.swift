//
//  TileFlowLayout.swift
//  2048_LazarStefania_Grupa333
//
//  Created by Student on 24.04.2023.
//

import Foundation

import UIKit

class TileFlowLayout: UICollectionViewFlowLayout {
    private let numberOfItemsPerRow: CGFloat = 4
    private let spacing: CGFloat = 10
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellWidth = (availableWidth - (numberOfItemsPerRow - 1) * spacing) / numberOfItemsPerRow
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributes = super.layoutAttributesForElements(in: rect) ?? []
        
        return allAttributes.compactMap { attributes in
            let newAttributes = layoutAttributesForItem(at: attributes.indexPath)
            return newAttributes
        }
    }


    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let numberOfItemsPerRow: CGFloat = 4
        let spacing: CGFloat = 10
        let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellWidth = (availableWidth - (numberOfItemsPerRow - 1) * spacing) / numberOfItemsPerRow
        
        let row = indexPath.item / Int(numberOfItemsPerRow)
        let column = indexPath.item % Int(numberOfItemsPerRow)
        
        let x = collectionView.contentInset.left + CGFloat(column) * (cellWidth + spacing)
        let y = collectionView.contentInset.top + CGFloat(row) * (cellWidth + spacing)
        
        attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellWidth)
        
        return attributes
    }

}
    
