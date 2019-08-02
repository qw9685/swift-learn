//
//  ViewController.swift
//  tableView联动
//
//  Created by foxdingding on 2018/12/10.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var isScrollDown:Bool = true
    var lastOffsetY:CGFloat = 0.0
    
    
    private lazy var tableView_first:UITableView = {
        
        var tableView_first = UITableView.init(frame: CGRect(x: 0, y: 64, width: 40, height: view.frame.size.height - 64), style: .plain);
        tableView_first.delegate = self
        tableView_first.dataSource = self
        tableView_first.backgroundColor = .red
        tableView_first.sectionHeaderHeight = 0
        tableView_first.rowHeight = 60
        return tableView_first
    }()
    
    private lazy var tableView_second:UITableView = {
        
        var tableView_second = UITableView.init(frame: CGRect(x: 40, y: 64, width: view.frame.size.width - 40, height: view.frame.size.height - 64), style: .plain);
        tableView_second.delegate = self
        tableView_second.dataSource = self
        tableView_second.backgroundColor = .white
        tableView_second.sectionHeaderHeight = 44
        tableView_second.separatorStyle = .none
        return tableView_second
    }()
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == self.tableView_second {
            var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerID")
            if header == nil{
                header = UITableViewHeaderFooterView.init(reuseIdentifier: "headerID")
                header?.textLabel?.font = UIFont.systemFont(ofSize: 16)
                header?.textLabel?.textColor = .red
            }
            header?.textLabel?.text = "\(section)"
            
            return header
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView_first{
            return 1
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView_first{
            return 10
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let isFirst : Bool = tableView == self.tableView_first
        
        var cell = tableView.dequeueReusableCell(withIdentifier:(isFirst ? "cellID_first":"cellID_second"))
        
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: (isFirst ? "cellID_first":"cellID_second"))
            if isFirst{
                cell?.backgroundColor = .red
                cell?.textLabel?.textColor = .white
            }
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView_first {
            selectRow(index: indexPath.row)
            tableView_second.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
        }
    }
    
    // 标记是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tableView = scrollView as! UITableView
        if  tableView_second == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
            
            if lastOffsetY>0{
                var alphaFloat = 64/lastOffsetY
                if alphaFloat >= 1{
                    alphaFloat = 1
                }
                self.navigationController?.navigationBar.alpha = alphaFloat
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (tableView_second == tableView) && !isScrollDown && (tableView_second.isDragging || tableView_second.isDecelerating) {
            selectRow(index: section)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if (tableView_second == tableView) && isScrollDown && (tableView_second.isDragging || tableView_second.isDecelerating) {
            selectRow(index: section + 1)
        }
    }
    
    private func selectRow(index : Int) {
        tableView_first.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "tableView联动效果"
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.alpha = 0
        
        view.addSubview(tableView_first)
        view.addSubview(tableView_second)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


