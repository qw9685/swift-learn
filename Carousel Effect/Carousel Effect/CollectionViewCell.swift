//
//  CollectionViewCell.swift
//  Carousel Effect
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    lazy var ThumbnailImageView : UIImageView = {
        var ThumbnailImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: self.frame.size.width - 10, height: self.frame.size.height))
        ThumbnailImageView.contentMode = .scaleAspectFill
        ThumbnailImageView.clipsToBounds = true
        return ThumbnailImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.ThumbnailImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
