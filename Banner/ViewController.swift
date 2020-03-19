//
//  ViewController.swift
//  Banner
//
//  Created by ATH on 2020/3/18.
//  Copyright © 2020 sco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var bannerView:BannerView?
    override func viewDidLoad() {
         super.viewDidLoad()
         let screenSize = UIScreen.main.bounds.size
        bannerView = BannerView(frame: CGRect(x:10,y:50,width:screenSize.width-20,height:200))
        bannerView?.setDataSource(getDataSource())
        view.addSubview(bannerView!)
        bannerView?.startAutoScroll()

    }
    
    func getDataSource()->[BannerModel]{
        var bannerModels:[BannerModel] = [BannerModel]();
        let model1:BannerModel = BannerModel()
        model1.imageId = "banner"
        bannerModels.append(model1)
        
        let model2:BannerModel = BannerModel()
        model2.imageId = "banner2"
        bannerModels.append(model2)
        
        let model3:BannerModel = BannerModel()
        model3.imageId = "banner3"
        bannerModels.append(model3)
        
        
        return bannerModels
    }


}

