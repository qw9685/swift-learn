//
//  mapViewController.swift
//  MapKit
//
//  Created by foxdingding on 2018/12/7.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController,MKMapViewDelegate {

    var loc = String.init()
    var currentLocationSpan = MKCoordinateSpan()
    let objectAnnotation = MKPointAnnotation()//大头针
    
    private lazy var mapView:MKMapView = {
        var mapView = MKMapView(frame:self.view.frame)
        //地图类型设置 - 标准地图
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow;
        //1. 设置交通状况
        mapView.showsTraffic = true;
        //2. 设置指南针(默认就是YES), 屏幕旋转后会出现, 如果点击会校正方向
        mapView.showsCompass = true;
        //3. 设置比例尺
        mapView.showsScale = true;
    
        mapView.delegate = self
        
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        var latDelta = 0.05
        var longDelta = 0.05
        currentLocationSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        //转换经纬度
        getLocation(lcation: loc) { (latitude, location, isGet) in
         
            self.setMapLocation(latitude: latitude, longitude: location)
        }
    }
    
    func setMapLocation(latitude:CLLocationDegrees,longitude:CLLocationDegrees) -> () {
        
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        //设置显示区域
        mapView.setRegion(currentRegion, animated: true)
        
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        
        //设置点击大头针之后显示的标题
        objectAnnotation.title = loc
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
        //添加大头针
        mapView.addAnnotation(objectAnnotation)
    }

    func getLocation(lcation:String, complete: @escaping (CLLocationDegrees,CLLocationDegrees,Bool)->()){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(lcation as String, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if error != nil {
                
                let alertVc = UIAlertController(title: "获取经纬度错误", message: "\(error.debugDescription)", preferredStyle: UIAlertControllerStyle.alert)
                let sureAction = UIAlertAction(title: "确定", style: .cancel, handler: { (sureAction) in
                    
                });
                alertVc.addAction(sureAction)
                self.present(alertVc, animated: true, completion: {
                });
                
                return
            }
            
            if let loc = placemarks?[0]{
                complete(loc.location!.coordinate.latitude,loc.location!.coordinate.longitude,true)
            } else {
                complete(0,0,false)
            }
        })
    }
}
