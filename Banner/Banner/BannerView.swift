//
//  BannerView.swift
//  Banner
//
//  Created by ATH on 2020/3/18.
//  Copyright © 2020 sco. All rights reserved.
//

import UIKit

class BannerView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    let reuseIdentifier = "BannerCollectionViewCellId"
    let infinitePage = 2000
    var dataSource:[BannerModel]?
    var itemCornerRaduis:CGFloat = 15
    var infiniteScroll:Bool = true
    var timer:Timer?
    var scrollInterval:TimeInterval = 2
    var currentRealPage:Int = 0
    var pageControll:UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.currentPageIndicatorTintColor = UIColor.init(displayP3Red: 0.7, green: 0.8, blue: 0.2, alpha:1)
        return pageControll
    }()
    var layout:UICollectionViewScalScrollFlowLayout = {
       var layout = UICollectionViewScalScrollFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
       return layout
    }()
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame:frame, collectionViewLayout: layout)
        super.init(frame: frame)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier:reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        addSubview(collectionView)
        addSubview(pageControll)
        collectionView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        pageControll.frame = CGRect(x:0,y:frame.size.height-20,width:frame.size.width,height: 10)
        
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        scrollToDefaultPosition()
    }
    
    func startAutoScroll(){
        guard timer == nil else{
            return
        }
        timer = Timer.scheduledTimer(timeInterval:scrollInterval, target: self, selector:#selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    func stopAutoScroll(){
        guard timer != nil else{
                   return
        }
        timer?.invalidate()
        timer = nil
    }
    @objc func scrollToNextPage() -> (Void) {
        let count = self.dataSource?.count ?? 1
        self.currentRealPage += 1
        if(self.currentRealPage >= infinitePage - 100&&self.currentRealPage%count == 0){
             self.currentRealPage  = 100 - 100 % (self.dataSource?.count ?? 1)
               self.collectionView .scrollToItem(at: IndexPath.init(row: self.currentRealPage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
            self.currentRealPage += 1
        }
        
        self.collectionView .scrollToItem(at: IndexPath.init(row: self.currentRealPage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    func setDataSource(_ dataSource:[BannerModel]){
        self.dataSource = dataSource;
        collectionView.reloadData()
        pageControll.currentPage = 0;
        pageControll.numberOfPages = self.dataSource?.count ?? 0
    }
    func scrollToDefaultPosition() {
           if self.infiniteScroll {
            let defaultPage = 100 - 100 % (self.dataSource?.count ?? 1)
            currentRealPage = defaultPage
            collectionView.scrollToItem(at:IndexPath(item: defaultPage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        }
    }

        /**
         设置PageControl 当前显示的页面
         @param contentOffsetX 当前偏移量
         */
    func setPageControlCurrentPage(offsetX:CGFloat) {
        let pageW:CGFloat = self.layout.itemSize.width;
        let f:CGFloat =  offsetX / pageW;
        var currentPage:Int = Int(f)
        if (f - CGFloat(currentPage)) > 0.5 {
            currentPage += 1
        }
        self.currentRealPage = currentPage
        self.pageControll.currentPage = currentPage % self.dataSource!.count
        
    }

   
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = dataSource?.count ?? 0
        if count == 0 {
            return 0
        }
        if(!self.infiniteScroll){
            return count
        }
        
        return infinitePage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath) as! BannerCollectionViewCell
        let index = indexPath.row % dataSource!.count
        let bannerModel:BannerModel = dataSource![index]
        cell.layer.cornerRadius = self.itemCornerRaduis
        cell.clipsToBounds = true
        cell.bannerModel = bannerModel
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setPageControlCurrentPage(offsetX: scrollView.contentOffset.x)
    }
   
 
}
