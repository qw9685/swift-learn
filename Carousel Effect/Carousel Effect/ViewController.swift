//
//  ViewController.swift
//  Carousel Effect
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    var assetsFetchResults : PHFetchResult<PHAsset>?
    var imageManager : PHCachingImageManager?
    
    private lazy var collection:collectionView = {
        
        let collection = collectionView(frame: self.view.bounds)
        return collection
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view .addSubview(collection)
        loadPhotoFromAlbum()
        
        DispatchQueue.main.async {
            self.collection.assetsFetchResults = self.assetsFetchResults
            self.collection.imageManager = self.imageManager
            self.collection.collectionView.reloadData()
        }
    }
    
    func loadPhotoFromAlbum()->(){
        
        //获取所有资源
        let allPhotosOptions = PHFetchOptions()
        //按照创建时间倒序排列
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: false)]
        //只获取图片
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                 PHAssetMediaType.image.rawValue)
        
        self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
                
        // 初始化和重置缓存
        self.imageManager = PHCachingImageManager()
        resetCachedAssets()
    }
    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager?.stopCachingImagesForAllAssets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

