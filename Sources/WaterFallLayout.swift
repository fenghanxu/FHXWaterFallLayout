//
//  WaterFallLayout.swift
//  waterFall
//
//  Created by Tiny on 2017/5/22.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

/*
 说明一下:
 使用collectionView的时候要用WaterFallLayout，放到collectionView里面
 需要遵守dataSource实现两个方法
 第一个方法:设置一行有多小个 个数
 第二个设置每个cell的个数。(这个需要自己计算图片的高度，生成一个数组，一个一个存进去)
 */

import UIKit

@objc public protocol WaterFallLayoutDataSource : class{
    
   func numberOfcols(_ waterFall:WaterFallLayout) ->Int
   @objc optional func waterFall(_ waterFall:WaterFallLayout,item:Int) -> CGFloat
    
}

public class WaterFallLayout: UICollectionViewFlowLayout {

    public weak var dataSource:WaterFallLayoutDataSource?
    
    lazy var attrs:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var cols:Int = {
        return self.dataSource?.numberOfcols(self) ?? 2
    }()
    
    lazy var heights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    fileprivate var startIndex:Int = 0
    
}

// MARK: - 准备item atts 数据
extension WaterFallLayout{
  override public func prepare() {
        super.prepare()
        
        //item个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let itemW:CGFloat = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*CGFloat(cols - 1))/CGFloat(cols)
        
        //创建指定个数的atts
        for i in startIndex..<itemCount {
            //计算indexPath
            let indexPath = IndexPath(item: i, section: 0)
            //创建atts
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
           
            guard  let itemH:CGFloat = dataSource?.waterFall!(self, item: i) else {
                fatalError("请实现对应的数据源方法，返回cell高度")
            }
            
            let height = heights.min()!
            let index = heights.index(of: height)!
            
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing)*CGFloat(index)

            let itemY:CGFloat = height + minimumLineSpacing
            
            //设置attr的frame
            attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            //保存heights
            heights[index] = height + minimumLineSpacing + itemH
            //保存frame
            attrs.append(attr)
        }
        //记录当前最大的count
        startIndex = itemCount
    }
}


// MARK: - 返回准备好的atts
extension WaterFallLayout{
  override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
}

// MARK: - 返回contentsize
extension WaterFallLayout{
  override public var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: heights.max()! + sectionInset.bottom)
    }
}

