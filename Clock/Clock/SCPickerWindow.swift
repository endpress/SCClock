//
//  SCPickerWindow.swift
//  Clock
//
//  Created by Snow on 15/11/14.
//  this is my code
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit


class SCPickerWindow: UIWindow {
    
    class func sharedInstance() ->SCPickerWindow {
        var instance:SCPickerWindow?
        var onceToken: dispatch_once_t = 0
        
        dispatch_once(&onceToken) { () -> Void in
            instance = SCPickerWindow.init(frame: UIScreen.mainScreen().bounds)
        }
        return instance!
    }
    
    func show() {
        
    }
    
    /* headerView  是上面的已经选择按钮
     * pickerview  是下面的选择按钮
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        let headerView = SCHeaderView.init(frame: CGRectMake(CGFloat(0), self.sc_height / 2, self.sc_width, (self.sc_height / 2) / 7))
        headerView.titleArray = ["小时", "分钟", "秒"]
        layoutPickerView()
        
        addSubview(headerView)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(CGFloat(0.1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK：加载选取日期视图
    //MARK: -
    var scrollview = UIScrollView()
    
    func layoutPickerView() {
        let scrollView = UIScrollView.init(frame: CGRectMake(CGFloat(0), self.sc_height / 2 * 8 / 7, self.sc_width, (self.sc_height / 2) * 6 / 7)) //5代表两个视图中的线
        let lineView = UIView.init(frame: CGRectMake(CGFloat(0), CGFloat(0), self.sc_width, CGFloat(2.0)))
        lineView.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        scrollView.addSubview(lineView)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.pagingEnabled = true
        scrollview = scrollView
        layoutButtonView()
        addSubview(scrollView)
    }
    
    //MARK: 加载子视图
    func layoutButtonView() {
        let hourView = UIView.init(frame: CGRectMake(CGFloat(0), CGFloat(0), scrollview.sc_width, scrollview.sc_height))
        let minView = UIView.init(frame: CGRectMake(scrollview.sc_width, CGFloat(0), scrollview.sc_width, scrollview.sc_height))
        hourView.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        minView.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        
        scrollview.contentSize = CGSizeMake(scrollview.sc_width * 2, CGFloat(0))
        scrollview.addSubview(hourView)
        scrollview.addSubview(minView)
    }
    
    //MARK:-
    //MARK:加载button视图
    
    func addButtonAt(superView:UIView) {
        
    }
    
}

