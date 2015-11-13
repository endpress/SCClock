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
    }
    
    func clockViewChanged(clockView: SCClockView, atCell: SCClockCell, toState: ClockSwitchState) {
        print("state == \(toState)")
        
    }
    
    
}

