//
//  ViewController.swift
//  CustomFont
//
//  Created by foxdingding on 2018/11/19.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum fontFamily{
        case one
        case two
        case three
    }
    
    var fontFam:fontFamily = .one
    
    private lazy var textLabel:UILabel = {
       
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2));
        label.backgroundColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "poqhdopaidpasodbaspodbasodbaso"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var changeBtn:UIButton = {
        
        let btn = UIButton(frame: CGRect(x: (self.view.frame.size.width - 100)/2, y: self.view.frame.size.height - 50, width: 100, height: 50));
        btn.backgroundColor = UIColor.black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle("changeFont", for: .normal)
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(changeFontAction(btn:)), for:.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view .addSubview(self.textLabel)
        view .addSubview(self.changeBtn)
    }
    
    @objc func changeFontAction(btn:UIButton) -> () {
        
        switch fontFam{
        case .one:
            self.textLabel.font = UIFont.systemFont(ofSize: 20)
            fontFam = .two
        case .two:
            self.textLabel.font = UIFont.systemFont(ofSize: 30)
            fontFam = .three
        case .three:
            self.textLabel.font = UIFont.systemFont(ofSize: 16)
            fontFam = .one
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

