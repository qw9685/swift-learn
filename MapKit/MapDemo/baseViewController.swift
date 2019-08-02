//
//  baseViewController.swift
//  MapKit
//
//  Created by foxdingding on 2018/12/7.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class baseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        if ((self.navigationController?.viewControllers.count)! <= 1) {
            (self.navigationController as! NavViewController).backBtn.isHidden = true
        }else{
            (self.navigationController as! NavViewController).backBtn.isHidden = false
        }
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
