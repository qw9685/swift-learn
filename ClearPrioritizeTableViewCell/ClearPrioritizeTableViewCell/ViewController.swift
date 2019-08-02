//
//  ViewController.swift
//  ClearPrioritizeTableViewCell
//
//  Created by foxdingding on 2018/12/3.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private lazy var tableView : UITableView = {
        
        var tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        
        cell!.accessoryType = .none
        cell?.selectionStyle = .none
        
        //渐变色
        let color = (CGFloat(indexPath.row) / CGFloat(100)) * 0.6
        cell?.backgroundColor = UIColor(red:1.0,  green: color,  blue:0.0,  alpha:1.0)
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


