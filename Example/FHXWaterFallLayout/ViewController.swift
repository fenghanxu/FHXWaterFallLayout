//
//  ViewController.swift
//  FHXWaterFallLayout
//
//  Created by fenghanxu on 08/10/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXWaterFallLayout

class ViewController: UIViewController {

  fileprivate lazy var collectionView: UICollectionView = {
    let layout = WaterFallLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.dataSource = self
    let collection:UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collection.delegate = self
    collection.dataSource = self
    collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    return collection
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  
  func buildUI(){
    view.backgroundColor = UIColor.white
    view.addSubview(collectionView)
    buildSubview()
  }
  
  func buildSubview(){
    collectionView.backgroundColor = UIColor.white
    collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
  }
 
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
    cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("选中item = \(indexPath.row)")
  }
}

extension ViewController : WaterFallLayoutDataSource{
  
  func numberOfcols(_ waterFall: WaterFallLayout) -> Int {
    return 3
  }
  
  func waterFall(_ waterFall: WaterFallLayout, item: Int) -> CGFloat {
    return CGFloat(arc4random_uniform(150)) + CGFloat(100)
  }
  
}

