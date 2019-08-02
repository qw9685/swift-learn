//
//  loginViewController.swift
//  SimpleLoginAnimation
//
//  Created by foxdingding on 2018/12/3.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    private lazy var userCountTextfiled: UITextField = {
        
        var userCountTextfiled = UITextField(frame: CGRect(x: -view.frame.size.width - 40, y: 100, width: view.frame.size.width - 40, height: 40))
        userCountTextfiled.placeholder = "账号"
        userCountTextfiled.textColor = UIColor.black
        userCountTextfiled.backgroundColor = UIColor.white
        userCountTextfiled.layer.cornerRadius = 8
        userCountTextfiled.layer.borderColor = UIColor.black.cgColor
        userCountTextfiled.layer.borderWidth = 1
        return userCountTextfiled
    }()
    
    private lazy var passWordTextfiled: UITextField = {
        
        var passWordTextfiled = UITextField(frame: CGRect(x: -view.frame.size.width - 40, y: 160, width: view.frame.size.width - 40, height: 40))
        passWordTextfiled.placeholder = "密码"
        passWordTextfiled.textColor = UIColor.black
        passWordTextfiled.backgroundColor = UIColor.white
        passWordTextfiled.layer.cornerRadius = 8
        passWordTextfiled.layer.borderColor = UIColor.black.cgColor
        passWordTextfiled.layer.borderWidth = 1
        
        return passWordTextfiled
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(userCountTextfiled)
        view.addSubview(passWordTextfiled)
        
        UIView.animate(withDuration: 1.0) {
            
            self.userCountTextfiled.frame.origin.x = 20
            self.passWordTextfiled.frame.origin.x = 20
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
