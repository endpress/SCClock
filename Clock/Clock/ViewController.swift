//
//  ViewController.swift
//  Clock
//
//  Created by ZhangSC on 15/11/12.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    var datasourceArray = NSMutableArray()
    let iden = "Cell"
    
    var w:UIWindow? = UIWindow()  //必须创建一个存储属性保存window，不然会无法持有window，从而不会显示
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().statusBarHidden = true
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: self.view.bounds)
//        tableView.backgroundColor = UIColor.sc_init(r:127, g:255, b:212, alpha: 1.0)
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.registerClass(SCClockCell.self, forCellReuseIdentifier: iden)
        self.view.addSubview(tableView)
    }

    @IBAction func setClock(sender: AnyObject) {
        let notification = UILocalNotification()
        notification.fireDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(5.0))
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.alertBody = "caonima"
        notification.alertTitle = "nimeide"
        notification.soundName = "alarm29.m4a"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource, ClockViewDelegate {

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: SCClockCell = (tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as? SCClockCell)!
        cell.selectionStyle = .None
        cell.clockView?.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell clicked == \(indexPath.row)")
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                tableView.contentOffset = CGPointMake(CGFloat(0), CGFloat(cell!.sc_y))
                }, completion: { (finish) -> Void in
                    self.w = SCPickerWindow.sharedInstance()
                    self.w!.makeKeyAndVisible()
                    self.w!.windowLevel = UIWindowLevelAlert
                    self.w!.hidden = false
                    let gesture = UITapGestureRecognizer.init(target: self, action: Selector("tapWindow:"))
                    self.w!.addGestureRecognizer(gesture)
            })
        }

    }
    
    //MARK:clockview 的代理方法  delegate
    
    func clockViewChanged(clockView: SCClockView, atCell: SCClockCell, toState: ClockSwitchState) {
        print("state == \(toState)")
        
    }
    
    //MARK:-
    //MARK: 处理点击window手势
    
    func tapWindow(gesture: UIGestureRecognizer) {
        
        let y = gesture.locationInView(self.view).y
        guard y <= self.w!.sc_height / 2 else { return }
        self.w!.hidden = true
        self.w!.resignKeyWindow()
        self.w = nil
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.tableView.contentOffset.y = 0
                }, completion: { (finish) -> Void in
                    
                })
        }
    }
    
    
}

