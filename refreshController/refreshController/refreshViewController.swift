//
//  refreshViewController.swift
//  refreshController
//
//  Created by foxdingding on 2018/11/23.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class refreshViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dataArray = NSMutableArray()
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "", ""]
    let newFavoriteEmoji = ["", "", "", "🤗🤗🤗🤗🤗", "", "" ]
    
    struct cellIDStruct{
        static var cellID : NSString = "cellID"
    }
    
    private lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        let shadow = NSShadow.init()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: view.frame.size.width, height: 2)
        shadow.shadowBlurRadius = 0.5
        let myAttribute = [
            NSAttributedStringKey.backgroundColor: UIColor.red,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.shadow: shadow,
            ]
        
        let myAttrString = NSAttributedString(string: "正在刷新", attributes: myAttribute)
        refreshControl.attributedTitle = myAttrString
        refreshControl.addTarget(self, action: #selector(reloadRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView:UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        tableView.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = self.refreshControl
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        tableView.separatorColor = UIColor.clear;
        tableView.rowHeight = 60
        
        return tableView
    }()
    
    //刷新数据
    @objc func reloadRefresh() -> () {
        
        self.dataArray.add(self.newFavoriteEmoji)
        
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIDStruct.cellID as String)
        
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIDStruct.cellID as String)
        }
        
        var str = String()
        (self.dataArray[indexPath.row] as! NSArray).enumerateObjects { (obj, idx, stop) in
            str.append(obj as! String)
        }
        cell?.textLabel?.text = str
        cell?.backgroundColor = UIColor.black
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "刷新控件"
        self.navigationItem.hidesBackButton = true
        
        self.dataArray.add(self.favoriteEmoji)
        view.addSubview(self.tableView)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
