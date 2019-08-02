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
    
    override func viewDidLayoutSubviews() {

        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            for (index,cell) in self.tableView.visibleCells.enumerated() {
                
                cell.layer.opacity = 0.0;
                cell.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 1, 0, 0);
                let delay = Double(index) * 0.8/20
                UIView .animate(withDuration: 2.0, delay: delay
                    , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {

                        cell.layer.opacity = 1.0;
                        cell.layer.transform = CATransform3DIdentity;

                }, completion: { (_) in

                });
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        
        cell!.accessoryType = .none
        cell?.selectionStyle = .none
        
        //渐变色
        let color = (CGFloat(indexPath.row) / CGFloat(20)) * 0.6
        cell?.backgroundColor = UIColor(red:1.0,  green: color,  blue:0.0,  alpha:1.0)

        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


