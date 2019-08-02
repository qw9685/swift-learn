//
//  threeView.swift
//  Snapchat Menu & Camera
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class threeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        
        let label = UILabel(frame: CGRect(x: 0, y: (self.frame.size.height - 40)/2, width: self.frame.size.width, height: 40))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = "第三个"
        self .addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
