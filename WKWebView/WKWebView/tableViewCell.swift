//
//  tableViewCell.swift
//  WKWebView
//
//  Created by foxdingding on 2018/12/19.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class tableViewCell: UITableViewCell {

    lazy var imgView :UIImageView = {
        var imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imgView.contentMode = .scaleAspectFill
        return imgView;
    }()
    
    lazy var titleLabel :UILabel = {
        var titleLabel = UILabel.init(frame: CGRect(x: self.imgView.frame.size.width, y: 0, width: UIScreen.main.bounds.size.width - self.imgView.frame.size.width, height: 30))
        titleLabel.textColor = .black;
        titleLabel.numberOfLines = 0
        titleLabel.isUserInteractionEnabled = false
        return titleLabel;
    }()
    
    lazy var deslabel :UITextView = {
        var deslabel = UITextView.init(frame: CGRect(x: self.imgView.frame.size.width, y: self.titleLabel.frame.size.height, width: self.titleLabel.frame.size.width, height: 70))
        deslabel.textColor = .lightGray;
        deslabel.isEditable = false
        deslabel.isUserInteractionEnabled = false
        return deslabel;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self .addSubview(imgView)
        self .addSubview(titleLabel)
        self .addSubview(deslabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
