//
//  GameViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/18.
//  Copyright © 2016年 HCL黄. All rights reserved.
//  这里处理了相同属性的属性用BaseModel来继承，传给CollectionViewGameCell的模型时也好处理

import UIKit

private let kEdgeMargin : CGFloat = 10.0
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return collectionView
    }()
    
    
    // MARK:- 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
        
        loadData()
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
        }
    }
}

// MARK:- 设置UI
extension GameViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

extension GameViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
    
        cell.group = gameVM.games[indexPath.item]
        return cell
        
    }
}
