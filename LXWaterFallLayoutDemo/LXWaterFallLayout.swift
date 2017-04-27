//
//  LXWaterFallLayout.swift
//  LXWaterFallLayoutDemo
//
//  Created by 刘行 on 2017/4/24.
//  Copyright © 2017年 刘行. All rights reserved.
//

import UIKit

protocol LXWaterFallLayoutDataSource : class {
    func numberOfColItems(_ layout : LXWaterFallLayout) -> Int
    func waterFall(_ layout : LXWaterFallLayout, heightForItem indexPath : IndexPath) -> CGFloat
}

class LXWaterFallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource : LXWaterFallLayoutDataSource?
    
    fileprivate lazy var layoutAttributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var cellHeights : [CGFloat] = {
        let colNums = self.dataSource?.numberOfColItems(self) ?? 2
        let cellHeights : [CGFloat] = Array(repeating: self.sectionInset.top, count: colNums)
        return cellHeights
    }()
    
}

//MARK:- 准备布局
extension LXWaterFallLayout {
    
    override func prepare() {
        
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        let colNums = dataSource?.numberOfColItems(self) ?? 2
        
        let cellW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat((colNums - 1)) * self.minimumInteritemSpacing) / CGFloat(colNums)
        
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)

            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let minHeight = cellHeights.min()!
            let minIndex = cellHeights.index(of: minHeight)!
            
            let cellX = self.sectionInset.left + CGFloat(minIndex) * (cellW + self.minimumInteritemSpacing)
            
            let cellY = minHeight
            
            let cellH : CGFloat = (self.dataSource?.waterFall(self, heightForItem: indexPath)) ?? 100
            
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            
            layoutAttributes.append(attr)
            
            cellHeights[minIndex] = cellY + cellH + minimumLineSpacing
            
        }
    }
    
}

//MARK:- 返回准备好的所有布局
extension LXWaterFallLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}

//MARK:- 设置滚动视图ContentSize
extension LXWaterFallLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: cellHeights.max()! + sectionInset.bottom)
    }
}
