//
//  recordViewController.swift
//  Snapchat Menu & Camera
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class scrollViewController: UIViewController {

    private lazy var scrollView : UIScrollView = {
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        scroll.bounces = false
        scroll.isPagingEnabled = true
        scroll.contentSize = CGSize(width: scroll.frame.size.width*3, height: scroll.frame.size.height)
        scroll.isScrollEnabled = true
        scroll.backgroundColor = UIColor.white
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view .addSubview(self.scrollView)
        
        let record = recordView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        let two = twoView(frame: CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        let three = threeView(frame: CGRect(x: view.frame.size.width*2, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        self.scrollView .addSubview(record)
        self.scrollView .addSubview(two)
        self.scrollView .addSubview(three)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
