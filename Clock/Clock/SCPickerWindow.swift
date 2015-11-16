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


public class SCPickerWindow: UIWindow, UIScrollViewDelegate {
    
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

        layoutPickerView()
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(CGFloat(0.1))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOriginalTime(time: String) {
        let h = time.substringToIndex(time.startIndex.advancedBy(2))
        let m = time.substringWithRange(Range(start: time.startIndex.advancedBy(3), end: time.startIndex.advancedBy(5)))
        let s = time.substringWithRange(Range(start: time.startIndex.advancedBy(6), end: time.startIndex.advancedBy(8)))
        layoutHeaderView([h + "点", m + "分", s + "秒"])
    }
    
    //MARK: -
    //MARK: 加载上面的headerview
    var buttonArray = NSMutableArray()
    
    func layoutHeaderView(titleArray: [String]) {
        let headerView = UIView.init(frame: CGRectMake(CGFloat(0), self.sc_height / 2, self.sc_width, (self.sc_height / 2) / 7))
        headerView.layer.backgroundColor = UIColor.whiteColor().CGColor
        let count = titleArray.count
        let width = headerView.sc_width
        let height = headerView.sc_height
        
        guard count <= 3 else{ return }
        
        for  i in 0..<count {
            var rect = CGRectMake(width / 4 * CGFloat(i), CGFloat(0), width / 4, height)
            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(CGFloat(5), CGFloat(5), CGFloat(5), CGFloat(5)))
            let button = UIButton.init(frame: rect)
            if i == 0 {
                button.setBackgroundImage(UIImage.init(named: "bluelabel"), forState: .Normal)
            } else {
                button.setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            }
            button.setTitle(titleArray[i], forState: .Normal)
            button.tag = 120 + i
            button.addTarget(self, action: Selector("labelButtonClick:"), forControlEvents: .TouchUpInside)
            buttonArray.addObject(button)
            headerView.addSubview(button)
        }
        let f = CGRectMake(width / 4 * CGFloat(3), CGFloat(0), width / 4, height)
        let OKButton = UIButton.init(frame: UIEdgeInsetsInsetRect(f, UIEdgeInsetsMake(CGFloat(5), CGFloat(5), CGFloat(5), CGFloat(5))))
        OKButton.setTitle("确定", forState: .Normal)
        OKButton.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        OKButton.layer.cornerRadius = 10.0
        OKButton.addTarget(self, action: Selector("OK"), forControlEvents: .TouchUpInside)
        headerView.addSubview(OKButton)
        
        addSubview(headerView)
    }
    
    //MARK: -
    //MARK: 加载选取日期视图
    var scrollview = UIScrollView()
    
    func layoutPickerView() {
        let scrollView = UIScrollView.init(frame: CGRectMake(CGFloat(0), self.sc_height / 2 * 8 / 7, self.sc_width, (self.sc_height / 2) * 6 / 7))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.pagingEnabled = true
        scrollview = scrollView
        scrollView.delegate = self
        layoutButtonView()
        addSubview(scrollView)
    }
    
    //MARK: 加载子视图 button
    func layoutButtonView() {
        let hourView = UIView.init(frame: CGRectMake(CGFloat(0), CGFloat(0), scrollview.sc_width, scrollview.sc_height))
        let minView = UIView.init(frame: CGRectMake(scrollview.sc_width, CGFloat(0), scrollview.sc_width, scrollview.sc_height))
        let secView = UIView.init(frame: CGRectMake(scrollview.sc_width * 2, CGFloat(0), scrollview.sc_width, scrollview.sc_height))
        hourView.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        minView.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        secView.backgroundColor = UIColor.sc_init(r: 135, g: 206, b: 250, alpha: 1.0)
        
        addButtonAt(hourView, titleArray: ["07", "08", "06", "05", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"], tag: 1)
        addButtonAt(minView, titleArray: ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "07", "17", "27"], tag: 2)
        addButtonAt(secView, titleArray: ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "07", "17", "27"], tag: 3)
        
        scrollview.contentSize = CGSizeMake(scrollview.sc_width * 3, scrollview.sc_height)
        scrollview.addSubview(hourView)
        scrollview.addSubview(minView)
        scrollview.addSubview(secView)
    }
    
    //MARK: -
    //MARK: 加载button视图
    
    func addButtonAt(superView:UIView, titleArray:[String], tag: Int) {
        let buttonSize = superView.sc_width / 4
        let buttonHeight = superView.sc_height / 4
        for i in 0 ..< titleArray.count {
            let button = UIButton.init(frame: CGRectMake(CGFloat(i % 4) * buttonSize, CGFloat((i) / 4) * buttonHeight, buttonSize, buttonHeight))
            button.setTitle(titleArray[i], forState: .Normal)
            button.tag = tag + 110
            button.addTarget(self, action: Selector("dateButton:"), forControlEvents: .TouchUpInside)
            superView.addSubview(button)
        }
    }
    
    
    // date选择器
    func dateButton(sender: UIButton) {
        let button = buttonArray[sender.tag - 110 - 1]
        let array = ["点", "分", "秒"]
        button.setTitle(sender.titleLabel!.text! + array[sender.tag - 110 - 1], forState: .Normal)
        let rect = CGRectMake(CGFloat(sender.tag - 110) * scrollview.sc_width, CGFloat(0), scrollview.sc_width, scrollview.sc_height)
        scrollview.scrollRectToVisible(rect, animated: true)
    }
    
    func labelButtonClick (sender: UIButton) {
        let rect = CGRectMake(CGFloat(sender.tag - 120) * scrollview.sc_width, CGFloat(0), scrollview.sc_width, scrollview.sc_height)
        scrollview.scrollRectToVisible(rect, animated: true)
    }
    
    //OK按钮被点击
    public var OKHander: ((time: String) ->Void)?
    
    func OK() {
        var timeString = String()
        for b in buttonArray {
            if let bn = b as? UIButton {
                timeString += bn.titleLabel!.text!
            }
        }
        timeString = timeString.stringByReplacingOccurrencesOfString("点", withString: ":")
        timeString = timeString.stringByReplacingOccurrencesOfString("分", withString: ":")
        timeString = timeString.stringByReplacingOccurrencesOfString("秒", withString: "")
        OKHander!(time: timeString)
    }
    
    //MARK: -
    //MARK: scrollview的delegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = scrollView.sc_width
        let offsetX = scrollView.contentOffset.x
        switch offsetX {
        case 0 ..< width / 2 :
            buttonArray[0].setBackgroundImage(UIImage.init(named: "bluelabel"), forState: .Normal)
            buttonArray[1].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            buttonArray[2].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
        case width / 2 ..< width * 3 / 2 :
            buttonArray[0].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            buttonArray[1].setBackgroundImage(UIImage.init(named: "bluelabel"), forState: .Normal)
            buttonArray[2].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
        case width * 3 / 2 ..< width * 2 :
            buttonArray[0].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            buttonArray[1].setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            buttonArray[2].setBackgroundImage(UIImage.init(named: "bluelabel"), forState: .Normal)
            
        default: break
            
        }
        
    } 

}

