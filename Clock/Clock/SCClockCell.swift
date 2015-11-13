//
//  SCClockCell.swift
//  Clock
//
//  Created by Snow on 15/11/12.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit


class SCClockCell: UITableViewCell {
    
    var mainView: SCClockView?
    
    override func drawRect(rect: CGRect) {
        
        mainView = SCClockView.init(frame: rect)
        self.contentView.addSubview(mainView!)
    }
    
    
}