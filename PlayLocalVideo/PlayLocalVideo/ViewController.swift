//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by foxdingding on 2018/11/20.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MediaPlayer

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private lazy var assets : NSMutableArray = {
     
        let arr = NSMutableArray();
        return arr
    }()
    
    private lazy var listView : UITableView = {
    
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: .plain)
        tableView.bounces = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self;
        tableView.dataSource = self;
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view .addSubview(self.listView)
        
        loadPhotoFromAlbum { (assets) in
            self.assets = assets
            //主队列
            DispatchQueue.main.async {
                self.listView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.assets.count
    }
   

    let cellID: String = "cellID"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier:cellID)
        }
        
        var imageBtn:UIButton?
        for subView in (cell?.subviews)! {
            if subView is UIButton{
                imageBtn = subView as? UIButton
                break
            }
        }
        
        if imageBtn == nil{
            imageBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/3))
            cell?.addSubview(imageBtn!)
        }
        
        imageBtn?.tag = indexPath.row
        imageBtn?.addTarget(self, action: #selector(showMoview(btn:)), for: .touchUpInside)
        
        let asset:AVURLAsset = self.assets[indexPath.row] as! AVURLAsset
        let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
        
        concurrentQueue.async {
            let image:UIImage = self.getVideoImage(asset: asset)
            DispatchQueue.main.async {
                imageBtn?.setBackgroundImage(image, for: UIControlState.normal)
            }
        }
        
        return cell!
    }
    
    @objc func showMoview(btn:UIButton) -> () {
        
        let avUrlAsset = self.assets[btn.tag] as! AVURLAsset
        let movieController = MPMoviePlayerViewController(contentURL: avUrlAsset.url)!
        movieController.moviePlayer.prepareToPlay()
        movieController.moviePlayer.controlStyle = .fullscreen
        movieController.view.backgroundColor = UIColor.black
        movieController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.present(movieController, animated: true) {
            NotificationCenter.default.addObserver(forName: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: movieController.moviePlayer, queue: OperationQueue.main, using: { (noti) in
                let theMovie = noti.object as! MPMoviePlayerController
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: theMovie)
                movieController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func getVideoImage(asset:AVURLAsset) -> UIImage {
        
        let avAsset = AVAsset.init(url: asset.url)
        let generator = AVAssetImageGenerator.init(asset: avAsset)
        DispatchQueue.main.async {
            generator.maximumSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height/2)
        }
        generator.appliesPreferredTrackTransform = true
        let time: CMTime = CMTimeMakeWithSeconds(0.0, 600) // 取第0秒， 一秒600帧
        var actualTime: CMTime = CMTimeMake(0, 0)
        let cgImage: CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        
        return UIImage.init(cgImage: cgImage)
        
    }
    
    func loadPhotoFromAlbum(completionHandler: @escaping (_ assets: NSMutableArray) -> Void){
        let assetArray = NSMutableArray()
        let avAssetArray = NSMutableArray()
        
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        
        let result = PHAsset.fetchAssets(with: option)
        
        result.enumerateObjects { (asset, idx, stop) in
            if(asset.mediaType == PHAssetMediaType.video){
                assetArray .add(asset)
            }
        }
        
        let videoOption = PHVideoRequestOptions()
        videoOption.version = PHVideoRequestOptionsVersion.current;
        videoOption.isNetworkAccessAllowed = true;
        
        for videoAsset in assetArray {
            PHImageManager.default().requestAVAsset(forVideo: videoAsset as! PHAsset, options: videoOption, resultHandler: { (avasset, audioMix, array) in
                
                avAssetArray .add(avasset!)
                if(avAssetArray.count == assetArray.count){
                    completionHandler(avAssetArray)
                }
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

