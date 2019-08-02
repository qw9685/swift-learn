//
//  resertLocViewController.swift
//  MapKit
//
//  Created by foxdingding on 2018/12/6.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

typealias loc = (_ str: String) -> Void

class resertLocViewController: baseViewController {
    
    var locBlock: loc?
    
    private lazy var textFiled:UITextField = {
       
        var textFiled = UITextField.init(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: 40))
        textFiled.placeholder = "请输入定位地址"
        textFiled.textColor = .black
        textFiled.returnKeyType = .done
        textFiled.backgroundColor = UIColor.lightGray
        return textFiled
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "定位"
        view.backgroundColor = .white
        view.addSubview(textFiled)

        //监测pop
        (self.navigationController as! NavViewController).backBlock {
            self.navigationController?.view.layer.add(self.addAnimation(), forKey: kCATransition)
            self.navigationController?.popViewController(animated: false)
        }

    }
    
    func locBlock(_ block: @escaping loc) {
        
        locBlock = block
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (self.navigationController as! NavViewController).rightBtn.setTitle("保存", for: .normal)
        
        //保存
        (self.navigationController as! NavViewController).rightBlock {
            
            //执行闭包
            if self.locBlock != nil {
                self.locBlock!(self.textFiled.text!)
            }
            self.navigationController?.view.layer.add(self.addAnimation(), forKey: kCATransition)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //转场动画
    func addAnimation() -> (CATransition) {
        let transition = CATransition.init()
        transition.duration = 0.45
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromBottom;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        return transition
    }

}
