//
//  webViewController.swift
//  WKWebView
//
//  Created by foxdingding on 2018/12/19.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    var url: String?
    var exTitle: String?
    
     lazy var webView : WKWebView = {
        let webView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        return webView;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        
        let url = NSURL(string: self.url!)
        webView.load(URLRequest(url: url! as URL))
        // Do any additional setup after loading the view.
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
