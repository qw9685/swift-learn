//
//  ViewController.swift
//  SimpleLoginAnimation
//
//  Created by foxdingding on 2018/12/3.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var registElasticView : ElasticView = {
        
        var registElasticView = ElasticView.init(frame: CGRect(x: 20, y: view.frame.size.height - 120, width: view.frame.size.width - 40, height: 40))
        
        var registBtn = UIButton.init(frame: registElasticView.bounds)
        registBtn .setTitle("注册", for: .normal)
        registBtn .setTitleColor(UIColor.black, for: .normal)
        registBtn .titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registBtn .backgroundColor = UIColor.white
        registBtn .layer.cornerRadius = 8
        registBtn .addTarget(self, action: #selector(registAction(btn:)), for: .touchUpInside)
//        registBtn.clipsToBounds = false
//        registBtn.layer.borderColor = UIColor.clear.cgColor
        
        registElasticView.backgroundColor = UIColor.white
        registElasticView.addSubview(registBtn)
        
        return registElasticView
    }()

    private lazy var loginElasticView : ElasticView = {
        
        var loginElasticView = ElasticView.init(frame: CGRect(x: 20, y: view.frame.size.height - 60, width: view.frame.size.width - 40, height: 40))
        
        var loginBtn = UIButton.init(frame: registElasticView.bounds)
        loginBtn .setTitle("登录", for: .normal)
        loginBtn .setTitleColor(UIColor.black, for: .normal)
        loginBtn .titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn .backgroundColor = UIColor.clear
        loginBtn .layer.cornerRadius = 8
        loginBtn .addTarget(self, action: #selector(loginAction(btn:)), for: .touchUpInside)
//        loginBtn.clipsToBounds = false
//        loginBtn.layer.borderColor = UIColor.clear.cgColor
        
        loginElasticView.backgroundColor = UIColor.white
        loginElasticView.addSubview(loginBtn)
        
        return loginElasticView
    }()
    
    @objc func registAction(btn:UIButton) -> () {
        let registVc = registViewController()
        
        registElasticView.startAnimation {
            self.navigationController?.pushViewController(registVc, animated: true)
        }
    }
    
    @objc func loginAction(btn:UIButton) -> () {
        let loginVc = loginViewController()
        
        loginElasticView.startAnimation {
            self.navigationController?.pushViewController(loginVc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.black
        
        view.addSubview(registElasticView)
        view.addSubview(loginElasticView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

