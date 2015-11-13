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
    
    var clockView: SCClockView?
    
    //此时用这个方法，是因为cell初始化的时候，调用 init(style: UITableViewCellStyle, reuseIdentifier: String?) 此时候还得不到cell的frame
    //所以，延迟设置，调用set View的时候设置frame，同时设置子视图的frame
    override func drawRect(rect: CGRect) {
        clockView?.setView(rect)
    }
    
    //当调用cell.mainView.delegate的时候，mainView ＝ nil 所以要提前初始化mainview 不能放在drawrect方法里面初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clockView = SCClockView.init(frame: CGRectZero)
        self.contentView.addSubview(clockView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}