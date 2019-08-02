//
//  ViewController.swift
//  VideoBackground
//
//  Created by foxdingding on 2018/12/3.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private lazy var playerItem: AVPlayerItem = {
        
        var path = Bundle.main.path(forResource: "merge", ofType: ".mov")
        var url = NSURL.init(fileURLWithPath: path!)
        var playerItem = AVPlayerItem.init(url: url as URL)
        return playerItem
    }()
    
    private lazy var playerPlayer: AVPlayerLayer = {
        
        var playerPlayer = AVPlayerLayer.init(player: player)
        playerPlayer.frame = view.bounds;
        return playerPlayer
    }()
    
    private lazy var player: AVPlayer = {
        
        var player = AVPlayer.init(playerItem: self.playerItem)
        return player
    }()
    
    private lazy var videoPlayView: UIView = {
    
        var backView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        backView.backgroundColor = UIColor.white
        return backView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoPlayView);
        
        view.layer .addSublayer(self.playerPlayer)
        
        self.player.play();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

