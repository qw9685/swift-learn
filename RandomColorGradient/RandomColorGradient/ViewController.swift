//
//  ViewController.swift
//  RandomColorGradient
//
//  Created by foxdingding on 2018/11/23.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioRecorderDelegate {
    
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var soundMeters: CGFloat? // 声音数据
    
    private lazy var soundLabel: UILabel = {
        let soundLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        soundLabel.backgroundColor = UIColor.white
        soundLabel.textColor = UIColor.red
        soundLabel.font = UIFont.systemFont(ofSize: 18)
        soundLabel.text = "声音数据:"
        return soundLabel
    }()
    
    private lazy var colorView: UIView = {
        let colorView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        colorView.backgroundColor = UIColor.white
        return colorView
    }()
    
    let file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record.wav")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //开始录音
        view.addSubview(self.soundLabel)
        view.addSubview(self.colorView)
        
        if FileManager.default.fileExists(atPath: file_path!) {
            
            do{
                try FileManager.default.removeItem(atPath: file_path!)
            }catch let error{
                print("删除错误:\(error.localizedDescription)")
            }
        }
        beginRecord()
        NotificationCenter.default.addObserver(self, selector: #selector(updateView(notice:)), name: NSNotification.Name.init("updateMeters"), object: nil)
    }
    
    @objc private func updateView(notice: Notification) {
        soundMeters = notice.object as? CGFloat
        soundLabel.text = "声音数据:\(String(describing: soundMeters))"
        colorView.backgroundColor = UIColor(red: soundMeters!/255, green: soundMeters!/255, blue: soundMeters!/255, alpha: 1.0)
    }

    func beginRecord() -> () {
        let session = AVAudioSession.sharedInstance()
        //设置session类型
        do {
            try session.setCategory(AVAudioSessionCategoryRecord)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        
        //设置session动作
        do {
            try session.setActive(true)
            
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
        //录音设置，注意，后面需要转换成NSNumber，如果不转换，你会发现，无法录制音频文件，我猜测是因为底层还是用OC写的原因
        let recordSetting: [String: Any] =
            
        [AVSampleRateKey: NSNumber(value: 16000),
        //采样率
        AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
        //音频格式
        AVLinearPCMBitDepthKey: NSNumber(value: 16),
        //采样位数
        AVNumberOfChannelsKey: NSNumber(value: 2),
        //通道数
        AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)]
        //开始录音
        do {
        let url = URL(fileURLWithPath: file_path!)
        recorder = try AVAudioRecorder(url: url, settings: recordSetting)
        recorder!.isMeteringEnabled = true
        recorder!.prepareToRecord()
        recorder!.record()
            print("开始录音")
        } catch let err {
            print("录音失败:\(err.localizedDescription)")
        }
        
        
    }
    
    //结束录音
    func stopRecord() {
        if let recorder = self.recorder {
            if recorder.isRecording {
                print("正在录音，马上结束它，文件保存到了：\(file_path!)")
            }else{
                print("没有录音，但是依然结束它")
            }
            recorder.stop()
            self.recorder = nil
        }else {
            print("没有初始化")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

