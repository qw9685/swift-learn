//
//  ViewController.swift
//  WKWebView
//
//  Created by foxdingding on 2018/12/19.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    private lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: .plain);
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Model.exaidInfo.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? tableViewCell
        
        if cell == nil {
            cell = tableViewCell.init(style: .default, reuseIdentifier: "cellID") 
        }
        cell?.selectionStyle = .none
        let exaid =  Model.exaidInfo[indexPath.row]
        cell?.imgView.image = UIImage.init(named: exaid.img)
        cell?.titleLabel.text = exaid.name
        cell?.deslabel.text = exaid.detail
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exaid =  Model.exaidInfo[indexPath.row]
        let webVc = webViewController()
        webVc.url = exaid.url
        webVc.title = exaid.name
        self.navigationController?.pushViewController(webVc, animated: true)
        
    }
}

