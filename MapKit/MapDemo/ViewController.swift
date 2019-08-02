//
//  ViewController.swift
//  MapKit
//
//  Created by foxdingding on 2018/12/6.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: baseViewController,UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate{

    private lazy var tableView : UITableView = {
       
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var locations:NSMutableArray = {
       
        var locations = NSMutableArray.init()
        
        return locations
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.title = "地点"
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as! NavViewController).rightBtn.setTitle("添加", for: .normal)
        
        (self.navigationController as! NavViewController).rightBlock {
            
            let vc = resertLocViewController()
            vc.locBlock({ (text) in
                self.locations.add(text)
                self.tableView.reloadData()
            })
            self.navigationController?.view.layer.add(self.addAnimation(), forKey: kCATransition)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //转场动画
    func addAnimation() -> (CATransition) {
        let transition = CATransition.init()
        transition.duration = 0.45
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        return transition
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = self.locations[indexPath.row] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mapVc = mapViewController()
        mapVc.loc = (self.locations[indexPath.row] as? String)!
        self.navigationController?.pushViewController(mapVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

