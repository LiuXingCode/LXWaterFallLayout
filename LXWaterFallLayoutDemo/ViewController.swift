//
//  ViewController.swift
//  LXWaterFallLayoutDemo
//
//  Created by 刘行 on 2017/4/24.
//  Copyright © 2017年 刘行. All rights reserved.
//

import UIKit

fileprivate let KCellID = "KCellID"

class ViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = LXWaterFallLayout()
        layout.dataSource = self
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCellID)
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}


extension ViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
}

extension ViewController : LXWaterFallLayoutDataSource {
    
    func numberOfColItems(_ layout : LXWaterFallLayout) -> Int{
        return 5;
    }

    func waterFall(_ layout: LXWaterFallLayout, heightForItem indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(101)) + 100;
    }
}


