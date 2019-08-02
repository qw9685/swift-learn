//
//  NavViewController.swift
//  MapKit
//
//  Created by foxdingding on 2018/12/6.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

typealias right = () -> ()
typealias back = () -> ()

class NavViewController: UINavigationController {

    var rightBlock: right?
    var backBlock: back?
    
    lazy var rightBtn : UIButton = {
        
        var rightBtn = UIButton.init(frame: CGRect(x: view.frame.size.width - 44 - 20, y: 0, width: 44, height: 44));
        rightBtn .setTitleColor(UIColor.white, for: .normal)
        rightBtn .addTarget(self, action: #selector(rightAction(btn:)), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy var backBtn : UIButton = {
        
        var backBtn = UIButton.init(frame: CGRect(x: 20, y: 0, width: 44, height: 44));
        backBtn .setTitleColor(UIColor.white, for: .normal)
        backBtn .setTitle("返回", for: .normal)
        backBtn .addTarget(self, action: #selector(backAction(btn:)), for: .touchUpInside)
        return backBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = .red
//不显示？？？
//        let item = UIBarButtonItem(customView: rightBtn)
//        self.navigationItem.rightBarButtonItem = item
        
        self.navigationBar .addSubview(rightBtn)
        self.navigationBar .addSubview(backBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func rightBlock(_ block: @escaping right) {
        
        rightBlock = block
    }
    
    func backBlock(_ block: @escaping right) {
        
        backBlock = block
    }
    
    @objc func rightAction(btn: UIButton) -> () {
        //执行闭包
        if self.rightBlock != nil {
            self.rightBlock!()
        }
    }
    
    @objc func backAction(btn:UIButton) -> () {
        //执行闭包
        if self.backBlock != nil {
            self.backBlock!()
            return
        }
        
        self.back()
    }
    
    func back() -> () {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
