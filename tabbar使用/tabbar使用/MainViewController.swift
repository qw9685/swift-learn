//
//  MainViewController.swift
//  tabbar使用
//
//  Created by foxdingding on 2018/12/12.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.tintColor = UIColor.red //tabbar 字体颜色
        tabBar.barTintColor = UIColor.white //tabbar 背景颜色
        
        self .addChirdVc(childVC: FirstViewController(), title: "First", imageName: "", seletedImageName: "")
        
        self .addChirdVc(childVC: secondViewController(), title: "Second", imageName: "", seletedImageName: "")
        
        self .addChirdVc(childVC: thirdViewController(), title: "Third", imageName: "", seletedImageName: "")
        
    }

    func addChirdVc(childVC:UIViewController, title:String, imageName:String, seletedImageName:String){
        
        childVC.title = title
        childVC.navigationController?.navigationBar.topItem?.title=title;
        childVC.tabBarItem.tag = 1
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: seletedImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(childVC)
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
