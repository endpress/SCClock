//
//  SCNotification.swift
//  Clock
//
//  Created by ZhangSC on 15/11/17.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit

/* 这个类用来处理数据
*   方便整个app调用
*/
struct SCNotification {
    
    static var datasourceArray: NSMutableArray {              //存放时间的数组
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let array = userDefault.objectForKey("timeArray") {
            return array.mutableCopy() as! NSMutableArray
            } else {
            return NSMutableArray.init(array: ["07:00:00","07:00:00","07:00:00"])
            }
        }
        set {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(newValue, forKey: "timeArray")
        }
    }
    
    static var notiArray:[UILocalNotification] {              //存放LocakNotification的数组
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let array = userDefault.objectForKey("Notificaiton") {
            return array as! [UILocalNotification]
            } else {
                let arr = NSMutableArray.init(capacity: 3)
                for _ in 0...2 {
                let noti = createNotification(ClockSwitchState.Off)
                arr.addObject(noti)
                }
                return arr.copy() as! [UILocalNotification]
            }
        }
        set {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(newValue, forKey: "Notificaiton")
        }
    }
    
    //创建一个LocalNotification
    static func createNotification(state: ClockSwitchState) ->UILocalNotification {
        let notification = UILocalNotification()
//        notification.fireDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(5.0))
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.alertBody = "caonima"
        notification.alertTitle = "nimeide"
        notification.soundName = "alarm29.m4a"
        notification.userInfo = ["state": state.rawValue]
        
        return notification
    }
}