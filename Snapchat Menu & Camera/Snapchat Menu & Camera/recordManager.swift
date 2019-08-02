//
//  recordManager.swift
//  Snapchat Menu & Camera
//
//  Created by foxdingding on 2018/11/21.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import AVFoundation

class recordManager: NSObject,AVCapturePhotoCaptureDelegate {

    func takePhoto() -> () {
       let setting = AVCapturePhotoSettings.init(format: [AVVideoCodecKey:AVVideoCodecJPEG])
       self.imageOutput.capturePhoto(with: setting, delegate: self)
    }
    //拍照完成
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        let imageData = AVCapturePhotoOutput .jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        let image = UIImage(data: imageData!)
        
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            NSLog("保存失败")
        }else{
            NSLog("保存成功")
        }
    }
    
    func flashStatus() -> () {
        changeDevicePropertySafety { (device) in
            
            if self.videoCaptureDevice.torchMode == AVCaptureDevice.TorchMode.off{
                self.videoCaptureDevice.torchMode = AVCaptureDevice.TorchMode.on
            }else{
                self.videoCaptureDevice.torchMode = AVCaptureDevice.TorchMode.off
            }
        }
    }
    
    func changeDirection() -> () {
        changeDevicePropertySafety { (device) in
            
            let newVideoInput:AVCaptureDeviceInput
            var position:AVCaptureDevice.Position
            
            if device.position == .back{
                position = .front
            }else{
                position = .back
            }
            
            let videoCaptureDevice = self.getCameraDevice(position: position)
            
            do{
                newVideoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
            }catch{
                NSLog("切换前/后摄像头失败");
                return
            }
            
            //必选先 remove 才能询问 canAdd
            self.captureSession.removeInput(self.captureDeviceInput!)
            if self.captureSession.canAddInput(newVideoInput){
                self.captureSession.addInput(newVideoInput)
                self.captureDeviceInput = newVideoInput;
            }else{
                NSLog("切换前/后摄像头失败");
            }
            
            
        }
    }
    
    var cameralayer : CALayer!
    
    private lazy var captureSession :AVCaptureSession = {
        let session = AVCaptureSession()
        
        if session.canSetSessionPreset(.photo){
            session.sessionPreset = .photo
        }
        
        return session
    }()
    
    private lazy var videoCaptureDevice :AVCaptureDevice! = {
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        }()
    
    private lazy var captureDeviceInput :AVCaptureDeviceInput? = {
        
        var input:AVCaptureDeviceInput?
        do {
            var deviceInput = try AVCaptureDeviceInput.init(device: self.videoCaptureDevice)
            input = deviceInput
            
        }catch {
        }
        
        return input
    }()
    
    // 根据设备输出获得连接
    lazy var imageOutput :AVCapturePhotoOutput = {
        
        var imageOutput = AVCapturePhotoOutput.init()
        return imageOutput
    }()

    // 根据设备输出获得连接
    private lazy var captureConnection :AVCaptureConnection? = {


        var captureConnection = self.imageOutput.connection(with: AVMediaType.video);
        return captureConnection
        
    }()
    
    // 相机拍摄预览图层
    private lazy var captureVideoPreviewLayer :AVCaptureVideoPreviewLayer? = {
        
        var captureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: self.captureSession)
        captureVideoPreviewLayer.videoGravity = .resizeAspectFill;//填充模式
        captureVideoPreviewLayer.frame = self.cameralayer.bounds;
        captureVideoPreviewLayer.session = self.captureSession
        return captureVideoPreviewLayer
    }()
    
    
    //初始化
     func initRecord(layer:CALayer) -> () {
        
        self.cameralayer = layer
        
        let startTime = CFAbsoluteTimeGetCurrent()
        self.initCaptureSession()
        let linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        print("Linked in \(linkTime*1000.0) ms")

    }
    
    func initCaptureSession() -> () {
        
        // 将视频输入添加到AVCaptureSession
        if self.captureSession .canAddInput(self.captureDeviceInput!){
            self.captureSession.addInput(self.captureDeviceInput!)
        }
        // 将输出流添加到AVCaptureSession
        if self.captureSession .canAddOutput(self.imageOutput) {
            self.captureSession.addOutput(self.imageOutput)
            
            // 判断是否支持光学防抖
            if self.videoCaptureDevice.activeFormat.isVideoStabilizationModeSupported(.auto) {
                // 如果支持防抖就打开防抖
                self.captureConnection?.preferredVideoStabilizationMode = .auto
            }
            
            //自动白平衡
            if self.videoCaptureDevice.isWhiteBalanceModeSupported(.autoWhiteBalance) {
                self.videoCaptureDevice.whiteBalanceMode = .autoWhiteBalance
            }
        }
        
        // 创建预览图层
        self.cameralayer.insertSublayer(self.captureVideoPreviewLayer!, at: 0)
        
        self.captureSession.startRunning()
    }
    
    // 获取摄像头设备
    func getCameraDevice(position:AVCaptureDevice.Position) -> AVCaptureDevice? {
        
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: position)
        
        for device in deviceDescoverySession.devices {
            if device.position == position {
                if device.supportsSessionPreset(.photo){
                    return device;
                }else{
                    return nil;
                }
            }
        }
        return nil;
    }

    func changeDevicePropertySafety(completionHandler: @escaping (_ captureDevice: AVCaptureDevice) -> Void){

        let captureDevice = self.captureDeviceInput?.device
        
        do {
            try captureDevice?.lockForConfiguration()
        } catch {
            NSLog("锁定设备过程error，错误信息：%@",error.localizedDescription);
            return
        }
        
        self.captureSession.beginConfiguration()
        completionHandler(captureDevice!)
        captureDevice?.unlockForConfiguration()
        self.captureSession.commitConfiguration()
    }
}
