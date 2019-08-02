//
//  ViewController.swift
//  EmojiSlotMachine
//
//  Created by foxdingding on 2018/12/4.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    private lazy var pickerView : UIPickerView = {
    
        var pickerView = UIPickerView.init(frame: CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: 60));
        pickerView.delegate = self;
        pickerView.dataSource = self;
        //默认值
        pickerView.selectRow(1,inComponent:0,animated:true)
        pickerView.selectRow(2,inComponent:1,animated:true)
        pickerView.isUserInteractionEnabled = false
        
        return pickerView;
    }()
    
    private lazy var lotteryBtn : UIButton = {
        
        var lotteryBtn = UIButton.init(frame: CGRect(x: 40, y: 200, width: view.frame.size.width - 80, height: 40))
        lotteryBtn.setTitle("摇一摇", for: .normal)
        lotteryBtn.backgroundColor = UIColor.black
        lotteryBtn.setTitleColor(UIColor.white, for: .normal)
        lotteryBtn.addTarget(self, action: #selector(lotteryBtn(btn:)), for: .touchUpInside)
        
        return lotteryBtn;
    }()
    
    private lazy var dataArray : NSArray = {

        var dataArray:NSArray = [["😞","😔","😨","😡","🤥","🤢","🤒","🤬"],["🤲","🤜","✌️","🤘","☝️"]]
        
        return dataArray;
    }()
    
    //点击按钮
    @objc func lotteryBtn(btn:UIButton) -> () {
        //开始动画
        
        for (index,arr) in dataArray.enumerated(){
            let array = arr as! NSArray
            pickerView.selectRow(Int(arc4random_uniform(UInt32(array.count)) + 0), inComponent: index, animated: true)
        }
    }
    
    //列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return dataArray.count
    }
    
    //行数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return (dataArray[component] as! NSArray).count
    }
    
    //内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        let array : NSArray = dataArray[component] as! NSArray
        
        return array[row] as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(pickerView)
        view.addSubview(lotteryBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

