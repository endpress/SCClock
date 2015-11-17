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
    let iden = "Cell"
    var w:SCPickerWindow?  //必须创建一个存储属性保存window，不然会无法持有window，从而不会显示
    
    var datasourceArray: NSMutableArray {              //存放时间的数组
        get {
            return SCNotification.datasourceArray
        }
        set {
            SCNotification.datasourceArray = newValue
        }
    }
    
    var notiArray:[UILocalNotification] {              //存放LocakNotification的数组
        get {
            return SCNotification.notiArray
        }
        set {
            SCNotification.notiArray = newValue
        }
    }
    
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
        return datasourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: SCClockCell = (tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as? SCClockCell)!
        cell.selectionStyle = .None
        cell.clockView!.delegate = self
        cell.clockView!.timeLabel.text = datasourceArray[indexPath.row] as? String
        let notiArr = notiArray
        if notiArr.count == datasourceArray.count {
            for noti in notiArr {
                if  let rawValue = noti.userInfo!["state"] as? Int {
                    let state = rawValue == 1 ? ClockSwitchState.On : ClockSwitchState.Off
                    cell.initState = state
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: SCClockCell = tableView.cellForRowAtIndexPath(indexPath) as! SCClockCell
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                tableView.contentOffset = CGPointMake(CGFloat(0), CGFloat(cell.sc_y))
                }, completion: { (finish) -> Void in
                    self.w = SCPickerWindow.sharedInstance()
                    self.w!.setOriginalTime(cell.clockView!.timeLabel.text!)
                    self.w!.makeKeyAndVisible()
                    self.w!.windowLevel = UIWindowLevelAlert
                    self.w!.hidden = false
                    let gesture = UITapGestureRecognizer.init(target: self, action: Selector("tapWindow:"))
                    self.w!.addGestureRecognizer(gesture)
                    self.w!.OKHander = {(time: String) ->Void in
                        cell.clockView!.timeLabel.text = time
                        let array = self.datasourceArray     //此处是为了触发set方法，直接赋值不会触发
                        array[indexPath.row] = time          //下面一样，为了触发notiarray set方法
                        self.datasourceArray = array         //
                        self.tapWindow(gesture)
                    }
            })
        }

    }
    
    //MARK:clockview 的代理方法  delegate
    
    func clockViewChanged(clockView: SCClockView, atCell: SCClockCell, toState: ClockSwitchState) {
        let indexPath = tableView.indexPathForCell(atCell)!
        print("state == \(toState) and indexpath == \(indexPath.row) and time == \(clockView.timeLabel.text!)")
        var array = notiArray
        switch toState {
            
        case .Off:
            
            var userInfo = array[indexPath.row].userInfo
            userInfo!["state"] = ClockSwitchState.Off.rawValue
            array[indexPath.row].userInfo = userInfo
            notiArray = array
            let noti = notiArray[indexPath.row]
            UIApplication.sharedApplication().cancelLocalNotification(noti)
        case .On:
            let timeStr = atCell.clockView!.timeLabel.text
            let noti = array[indexPath.row]
            noti.fireDate = stringToNSDate(timeStr!)
            noti.timeZone = NSTimeZone.defaultTimeZone()
            noti.repeatInterval = .Day
            noti.userInfo!["state"] = ClockSwitchState.On.rawValue
            array[indexPath.row] = noti
            notiArray = array
            UIApplication.sharedApplication().scheduleLocalNotification(notiArray[indexPath.row])
        }
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
    
    //转换字符串到nsdate
    func stringToNSDate(string: String) ->NSDate {
        let formatter = NSDateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.dateStyle = .FullStyle
//        let calendar = NSCalendar.autoupdatingCurrentCalendar()
//        let component = calendar.components(.Day, fromDate: NSDate())
//        component.hour = 7
//        component.minute = 5
//        component.second = 5
//        
//        let dateetete = calendar.dateFromComponents(component)
//        print(dateetete)
        let adf = NSDate.init(timeIntervalSince1970: 8*60*60)
        print(formatter.stringFromDate(adf))
        print(formatter.dateFromString(string))
        if let date = formatter.dateFromString(string) {
            print(date)
            return date
        } else { return NSDate() }
        
    }
    
    
}

