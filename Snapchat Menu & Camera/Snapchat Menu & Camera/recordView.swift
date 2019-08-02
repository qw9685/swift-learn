//
//  recordView.swift
//  Snapchat Menu & Camera
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class recordView: UIView {

    func Kwidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func Kheight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    var manager:recordManager!
    
    private lazy var topView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Kwidth(), height: 64))
        view.backgroundColor = UIColor.black
        view.alpha = 0.6
        
        let flashBtn = UIButton(frame: CGRect(x: Kwidth() - 100, y: 20, width: 80, height: 44))
        flashBtn.setTitle("闪光灯:开", for: .normal)
        flashBtn.setTitleColor(UIColor.white, for: .normal)
        flashBtn.addTarget(self, action: #selector(flashAction(btn:)), for:.touchUpInside)
        
        let DirectionBtn = UIButton(frame: CGRect(x: Kwidth() - 200, y: 20, width: 100, height: 44))
        DirectionBtn.setTitle("切换摄像头", for: .normal)
        DirectionBtn.setTitleColor(UIColor.white, for: .normal)
        DirectionBtn.addTarget(self, action: #selector(changeDirection(btn:)), for:.touchUpInside)
        
        view .addSubview(flashBtn)
        view .addSubview(DirectionBtn)
        
        return view
    }()
    
    private lazy var bottomView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: Kheight() - 100, width: Kwidth(), height: 100))
        view.backgroundColor = UIColor.black
        view.alpha = 0.6
        
        let recordBtn = UIButton(frame: CGRect(x: (view.frame.size.width - 60)/2, y: (view.frame.size.height - 60)/2, width: 60, height: 60))
        recordBtn.backgroundColor = UIColor.red
        recordBtn.layer.cornerRadius = 30
        recordBtn.setTitle("开始", for: .normal)
        recordBtn.setTitleColor(UIColor.white, for: .normal)
        recordBtn.addTarget(self, action: #selector(recordAction(btn:)), for:.touchUpInside)
        view .addSubview(recordBtn)
        
        return view
    }()
    
    @objc func recordAction(btn:UIButton) -> () {
        self.manager.takePhoto()
    }
    
    @objc func flashAction(btn:UIButton) -> () {
        self.manager.flashStatus()
    }
    
    @objc func changeDirection(btn:UIButton) -> () {
        self.manager.changeDirection()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initRecordControl()
        self.manager = recordManager.init()
        self.manager.initRecord(layer: self.layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //定义控件
    func initRecordControl() -> () {
    
        self.backgroundColor = UIColor.white
        self.addSubview(self.topView)
        self.addSubview(self.bottomView)
    }

}
