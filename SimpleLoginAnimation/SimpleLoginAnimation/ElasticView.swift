//
//  ElasticView.swift
//  SimpleLoginAnimation
//
//  Created by foxdingding on 2018/12/3.
//  Copyright © 2018年 foxdingding. All rights reserved.
//

import UIKit

class ElasticView: UIView {
    
    //线对象
    private let topControlPointView = UIView()
    private let leftControlPointView = UIView()
    private let bottomControlPointView = UIView()
    private let rightControlPointView = UIView()
    private let elasticShape = CAShapeLayer()
    
    //IBInspectable 属性暴露在面板上
    @IBInspectable var overshootAmount : CGFloat = 10
    
    private lazy var displayLink : CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(updateLoop))
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
        return displayLink
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(completionHandler: @escaping () -> Void) -> (){
        startUpdateLoop()
        animateControlPoints(completionHandler: completionHandler)
    }
    
    private func startUpdateLoop() {
        displayLink.isPaused = false
    }
    
    private func stopUpdateLoop() {
        displayLink.isPaused = true
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            if let newValue = newValue {
                elasticShape.fillColor = newValue.cgColor
                super.backgroundColor = UIColor.clear
            }
        }
    }

    func animateControlPoints(completionHandler: @escaping () -> Void) -> (){
        
        if displayLink.isPaused == true {
            return
        }
        
        //1
        let overshootAmount = self.overshootAmount
        
        // 2
        let options = UIViewAnimationOptions();
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.5, options: options, animations: {
            self.topControlPointView.center.y -= overshootAmount
            self.leftControlPointView.center.x -= overshootAmount
            self.bottomControlPointView.center.y += overshootAmount
            self.rightControlPointView.center.x += overshootAmount
        }) { (_) in
            // 4
            UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 5.5,
                                       options: options, animations: {
                                        // 5
                                        self.positionControlPoints()
            },
                                       completion: { _ in
                                        // 6
                                        completionHandler()
                                        self.stopUpdateLoop()
                                        
            })
        }
    }
    
    func setupComponents() -> () {
        
        elasticShape.fillColor = backgroundColor?.cgColor
        elasticShape.path = UIBezierPath(rect: self.bounds).cgPath
        layer.addSublayer(elasticShape)
        
        for controlPoint in [topControlPointView, leftControlPointView,
                             bottomControlPointView, rightControlPointView] {
                                addSubview(controlPoint)
                                controlPoint.frame = CGRect(x: 0.0, y: 0.0, width: 5.0, height: 5.0)
                                controlPoint.backgroundColor = UIColor.clear
        }
        
        positionControlPoints()
    }
    
    private func positionControlPoints(){
        topControlPointView.center = CGPoint(x: bounds.midX, y: 0.0)
        leftControlPointView.center = CGPoint(x: 0.0, y: bounds.midY)
        bottomControlPointView.center = CGPoint(x:bounds.midX, y: bounds.maxY)
        rightControlPointView.center = CGPoint(x: bounds.maxX, y: bounds.midY)
    }
    
    private func bezierPathForControlPoints()->CGPath {
        // 1
        let path = UIBezierPath()
        
        // 2
        let top = topControlPointView.layer.presentation()?.position
        let left = leftControlPointView.layer.presentation()?.position
        let bottom = bottomControlPointView.layer.presentation()?.position
        let right = rightControlPointView.layer.presentation()?.position
        
        let width = frame.size.width
        let height = frame.size.height
        
        // 3
        path.move(to: CGPoint(x: 0, y: 0))
        //        (to: CGPointMake(width, 0), controlPoint: top!)
        path.addQuadCurve(to: CGPoint(x: width, y: 0), controlPoint: top!)
        path.addQuadCurve(to: CGPoint(x: width, y: height), controlPoint:right!)
        path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint:bottom!)
        path.addQuadCurve(to: CGPoint(x:0, y:0), controlPoint: left!)
        
        // 4
        return path.cgPath
    }
    
    @objc func updateLoop() {
        elasticShape.path = bezierPathForControlPoints()
    }
    
}


