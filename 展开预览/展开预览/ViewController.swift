//
//  ViewController.swift
//  展开预览
//
//  Created by foxdingding on 2018/12/10.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private lazy var models:NSMutableArray = {
        
        var models = NSMutableArray.init()
        return models
    }()
    
    private lazy var tableView:UITableView = {
        
        var tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 64), style: .plain);
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerID")
        if header == nil{
            header = UITableViewHeaderFooterView.init(reuseIdentifier: "headerID")
            header?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            header?.textLabel?.textColor = .red
        }
//        header?.textLabel?.text = "\(section)"
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model : model = (models[indexPath.section] as! NSArray )[indexPath.row] as! model
        return model.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let m : NSArray = models[section] as! NSArray
        return m.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:"cellID")
        
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
            cell?.textLabel?.textColor = .black
        }
        cell?.textLabel?.text = "数据数据："
        for _ in 0...50 {
            cell?.textLabel?.text = cell?.textLabel?.text?.appending("\(indexPath.section)")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for (section,arr) in models.enumerated() {
            if section == indexPath.section{
                for (row,arr1) in (arr as! NSArray).enumerated() {
                    
                    let model : model = (models[section] as! NSArray )[row] as! model
                    
                    if row == indexPath.row{
                        if model.rowHeight == 44 {
                            model.rowHeight = 100
                        }else{
                            model.rowHeight = 44
                        }
                    }else{
                         model.rowHeight = 44
                    }
                }
            }
        }
        

        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "展开预览"
        view.addSubview(tableView)
        
        for _ in 0...10 {
            let m = model.init()
            let sectionArray = NSArray.init(object: m)
            self.models.add(sectionArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

