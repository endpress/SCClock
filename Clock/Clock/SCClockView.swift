//
//  SCClockView.swift
//  Clock
//
//  Created by Snow on 15/11/12.
//  this is my code
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit


class SCClockView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(CGFloat(20), CGFloat(10), CGFloat(20), CGFloat(10))))
        self.layer.backgroundColor = UIColor.sc_init(r: 255, g: 174, b: 185, alpha: 1.0)?.CGColor
        //设置阴影
        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = CGSizeMake(CGFloat(10.0), CGFloat(10.0))
        self.layer.shadowRadius = 10.0
        //设置其他样式
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.sc_init(r: 255, g: 174, b: 185, alpha: 1.0)?.CGColor
        
        //load SubView
        sc_layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 变量 用来存放子视图
    var timeLabel = UILabel() //中间可以滑动的视图
    var mainView = UIView()   //中间主要视图
    
    func sc_layoutSubviews() {
        mainView.frame = CGRectMake(CGFloat(0), CGFloat(0), self.sc_width * 0.8, self.sc_height) //0.8系数，来确定宽度
        mainView.layer.backgroundColor = UIColor.sc_init(r:127, g:255, b:212, alpha: 1.0)?.CGColor
        mainView.layer.cornerRadius = self.sc_height / 2
        
        //增加手势
        let gesture = UIPanGestureRecognizer.init(target: mainView, action: "panMainView:")
        mainView.addGestureRecognizer(gesture)
        addSubview(mainView)
    }
    
    func panMainView(sender: UIPanGestureRecognizer) {
        let state = sender.state
        
        switch state {
            
        case .Began:
             break
        case .Changed: break
            
        case .Ended: break
        case .Failed: break
            
        default: break
            
            
        }
        
        
    }
}