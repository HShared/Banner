//
//  BannerCollectionViewCell.swift
//  Banner
//
//  Created by ATH on 2020/3/18.
//  Copyright © 2020 sco. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    public var bannerModel:BannerModel?{
        didSet{
            imageView.image = UIImage(named: bannerModel!.imageId ?? "")
        }
        
    }
    let imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imageView)
    }
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
}
