//
//  UICollectionViewScalScrollFlowLayout.swift
//  Banner
//
//  Created by ATH on 2020/3/18.
//  Copyright © 2020 sco. All rights reserved.
//

import UIKit

class UICollectionViewScalScrollFlowLayout: UICollectionViewFlowLayout {
    var minScaleX:CGFloat = 0.8
    var minScaleY:CGFloat = 0.6
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributeArray = super .layoutAttributesForElements(in: rect)
        if minScaleX == 1.0 && minScaleY == 1.0 {
            return attributeArray
        }
        let pageWidth:CGFloat = self.itemSize.width + self.minimumInteritemSpacing
        let centerOffset:CGFloat = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width/2
        let count = attributeArray?.count ?? 0
        if(count == 0){
          
            return attributeArray
        }
        for index in 0..<count{
            let currentAttri:UICollectionViewLayoutAttributes = attributeArray![index]
            let attriCenterX = currentAttri.center.x
            var scaleX = self.minScaleX
            var scaleY = self.minScaleY
            if centerOffset - attriCenterX >= 0
                && centerOffset - attriCenterX <= pageWidth {
                let rate:CGFloat = (centerOffset-attriCenterX)/pageWidth;
                scaleX = 1-(1-self.minScaleX)*rate;
                scaleY = 1-(1-self.minScaleY)*rate;
            }else if attriCenterX-centerOffset>0
                && attriCenterX-centerOffset<pageWidth{
                scaleX = 1 - (1-self.minScaleX)*(attriCenterX - centerOffset)/pageWidth;
                scaleY = 1 - (1-self.minScaleY)*(attriCenterX - centerOffset)/pageWidth;
            }
            let transform:CGAffineTransform = CGAffineTransform(scaleX: scaleX, y: scaleY);
            currentAttri.transform = transform
        }
        return attributeArray
    }
  
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
  
}
