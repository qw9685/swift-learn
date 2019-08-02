//
//  ViewController.swift
//  SimpleStopWatch
//
//  Created by foxdingding on 2018/11/19.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberLabel : UILabel!
    var resertBtn : UIButton!
    var actionBtn : UIButton!
    var timer : Timer?//定时器
    
    private lazy var numberView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2));
        view.backgroundColor = UIColor.black;
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height));
        label.font = UIFont.systemFont(ofSize: 30);
        label.textColor = UIColor.white;
        label.textAlignment = NSTextAlignment.center
        self.numberLabel = label;
        view .addSubview(self.numberLabel)
        return view;
    }()
    
    private lazy var resertView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: self.numberView.frame.size.height, width: self.view.frame.size.width/2, height: self.view.frame.size.height/2));
        view.backgroundColor = UIColor.red;
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height));
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.setTitle("重置", for: UIControlState.normal)
        self.resertBtn = btn;
        view .addSubview(self.resertBtn)
        return view;
    }()
    
    private lazy var actionView: UIView = {
        
        let view = UIView(frame: CGRect(x: self.resertView.frame.size.width, y: self.resertView.frame.size.height, width: self.view.frame.size.width/2, height: self.view.frame.size.height/2));
        view.backgroundColor = UIColor.blue;
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height));
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30);
        btn.titleLabel?.textColor = UIColor.white;
        self.actionBtn = btn;
        view .addSubview(self.actionBtn)
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView();
    }

    func initView() -> (){
        view .addSubview(self.numberView)
        view .addSubview(self.resertView)
        view .addSubview(self.actionView)
        
        numberLabel.text = "0.0"
        resertBtn .setTitle("重置", for: UIControlState.normal)
        actionBtn .setTitle("开始", for: UIControlState.normal)
        
        resertBtn.addTarget(self, action: #selector(resertAction(btn:)), for:.touchUpInside)
        actionBtn.addTarget(self, action: #selector(action(btn:)), for:.touchUpInside)
    }
    
    @objc func resertAction(btn:UIButton) ->(){
        actionBtn .setTitle("开始", for: .normal)
        numberLabel.text = "0.0"
        stopTimer()
    }
    
    @objc func action(btn:UIButton) ->(){
        if btn.isSelected {
            btn .setTitle("开始", for: .normal)
            stopTimer()
        }else{
            btn .setTitle("暂停", for: .normal)
            startTimer()
        }
        btn.isSelected = !btn.isSelected
    }
    
    
    @objc func updataSecond() -> () {
        
        var number = Float(numberLabel.text!)
        number = number!+0.1
        numberLabel.text = String(format: "%.1f", number!)
    }
    
    func startTimer() -> (){
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        }

        //调用fire()会立即启动计时器
        timer!.fire()
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

