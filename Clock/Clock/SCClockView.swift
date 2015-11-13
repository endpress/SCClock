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

enum ClockSwitchState: Int {
    case On   = 1
    case Off  = 0
}

protocol ClockViewDelegate {
    
    func clockViewChanged(clockView: SCClockView, atCell: SCClockCell, toState: ClockSwitchState)
}

class SCClockView: UIView, UIGestureRecognizerDelegate {
    
    var delegate: ClockViewDelegate?
    //监听state变化
    var state:ClockSwitchState = .Off {
        didSet {
            self.delegate?.clockViewChanged(self, atCell: self.getCell(), toState: state)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)  //UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(CGFloat(20), CGFloat(10), CGFloat(20), CGFloat(10)))
    }
    
    //用来确定cell大小
    func setView (frame: CGRect) {
        self.frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(CGFloat(20), CGFloat(10), CGFloat(20), CGFloat(10)))
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
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
        let gesture = UIPanGestureRecognizer.init(target: self, action: "panMainView:")
        mainView.addGestureRecognizer(gesture)
        
        //时间 timeLabel
        timeLabel.frame = CGRectMake(CGFloat(0), CGFloat(0), self.sc_width * 0.5, self.sc_height * 0.8)
        timeLabel.center = mainView.center
        timeLabel.text = "7:00"
        timeLabel.font = UIFont(name: "Helvetica-Bold", size: 80.0)     //UIFont.systemFontOfSize(CGFloat(50.0), weight: CGFloat(5.0))
        timeLabel.textColor = UIColor.lightGrayColor()
        timeLabel.textAlignment = NSTextAlignment.Center
        mainView.addSubview(timeLabel)
        
        addSubview(mainView)
    }
    
    var originCenter: CGPoint?
    var originOffsety: CGFloat?
    
    func panMainView(sender: UIPanGestureRecognizer) {
        let state = sender.state
        let distanceX = sender.translationInView(mainView).x
        let tableview: UITableView = (self.superview!.superview!.superview!.superview! as? UITableView)! //得到tableView
        let distanceInTableview = sender.translationInView(tableview).y
        
        
        switch state {
            
        case .Began:
            originCenter = mainView.center
            originOffsety = tableview.contentOffset.y
            
        case .Changed:
            mainView.center = CGPointMake( originCenter!.x + distanceX, originCenter!.y)
            if mainView.sc_x >= self.sc_width * 0.2 { mainView.sc_x = self.sc_width * 0.2 }
            if mainView.sc_x <= 0 { mainView.sc_x = 0 }
            tableview.contentOffset.y = -distanceInTableview + originOffsety!
            
        case .Ended, .Failed:
            if mainView.sc_x >= self.sc_width * 0.1 {
                animateMainView(to: .On)
                if self.state == .Off {
                    self.state = .On
                }
            } else {
                animateMainView(to: .Off)
                if self.state == .On {
                    self.state = .Off
                }
            }
            
        default: break
            
        }
    }
    
    //动画操作
    func animateMainView(to state:ClockSwitchState) {
        var x:CGFloat
        var color:CGColorRef
        if state == .On {
            x = self.sc_width * 0.2
            color = (UIColor.sc_init(r: 67, g: 205, b: 128, alpha: 1.0)!.CGColor)
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            x = 0
            color = UIColor.whiteColor().CGColor
            timeLabel.textColor = UIColor.lightGrayColor()
        }
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                self.mainView.frame = CGRectMake(x, CGFloat(0), self.sc_width * 0.8, self.sc_height)
                //UIColor.sc_init(r: 255, g: 174, b: 185, alpha: 1.0)?.CGColor
                self.layer.backgroundColor = color
                }, completion: nil)
        }
    }
    
    //得到父视图
    func getCell() -> SCClockCell {
        return self.superview!.superview as! SCClockCell
    }
}