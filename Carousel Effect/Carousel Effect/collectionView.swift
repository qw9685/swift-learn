//
//  collectionView.swift
//  Carousel Effect
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import Photos

class collectionView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    struct cellIDStruct{
        static var cellID : NSString = "cellID"
    }
    
    var assetsFetchResults : PHFetchResult<PHAsset>?
    var imageManager : PHCachingImageManager?
    var imageSize:CGSize?
    
    private lazy var layout : UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: self.frame.size.width - 10, height: self.frame.size.height - 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.frame.size.width, height: self.frame.size.height - 200), collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIDStruct.cellID as String)
        return collectionView
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard (self.assetsFetchResults != nil) else {
            return 0
        }
        return self.assetsFetchResults!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDStruct.cellID as String, for: indexPath) as! CollectionViewCell
        
        //获取缩略图
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true//默认关闭
        options.resizeMode = .fast
        
        self.imageManager?.requestImage(for:self.assetsFetchResults![indexPath.item], targetSize: self.imageSize!, contentMode: .aspectFill, options: options, resultHandler: { (image, info) in
            cell.ThumbnailImageView.image = image
        })
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        self.imageSize = self.layout.itemSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
