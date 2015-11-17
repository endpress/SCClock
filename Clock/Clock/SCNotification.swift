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
    
    static var notiArray:[Int] {              //存放LocakNotification的数组
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let array = userDefault.objectForKey("Notificaiton") {
                return array as! [Int]
            } else {
                return [0, 0, 0]
            }
        }
        set {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(newValue, forKey: "Notificaiton")
        }
    }
    
}