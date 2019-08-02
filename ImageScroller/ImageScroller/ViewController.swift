//
//  ViewController.swift
//  ImageScroller
//
//  Created by foxdingding on 2018/11/23.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate{

    private lazy var scrollView:UIScrollView = {
       
        var scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height));
        
        //拿捏缩放
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 2.0
        
        // 双击缩放
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleClick(tap:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.isUserInteractionEnabled = true
        scrollView.addGestureRecognizer(doubleTap)
        
        return scrollView;
        
    }()
    
    private lazy var imageView :UIImageView = {
        
        var imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.image = UIImage.init(named: "未标题")
        return imageView;
    }()
    
    //双击缩放
    @objc func doubleClick(tap:UITapGestureRecognizer) -> () {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(scrollView);
        scrollView.addSubview(imageView);
    }

    //UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        // 设置被缩放的对应视图
        for imageview in scrollView.subviews
        {
            if imageview is UIImageView
            {
                return imageview
            }
        }
        return nil
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //置中
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 :0
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

