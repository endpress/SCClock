//
//  SCHeaderView.swift
//  SCPickerView
//
//  Created by Snow on 15/11/14.
//  this is my code
//  Copyright © 2015年 zsc. All rights reserved.
//

import Foundation
import UIKit


class SCHeaderView: UIView {
    
    var titleArray: [String]! {
        didSet {
            sc_layoutSubView()
        }
    }
    private var buttonArray = NSMutableArray.init(capacity: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func sc_layoutSubView() {
        
        let count = titleArray.count
        let width = self.bounds.width
        let height = self.bounds.height
        
        guard count <= 4 else{ return }
        
        for  i in 0..<count {
            var rect = CGRectMake(width / 4 * CGFloat(i), CGFloat(0), width / 4, height)
            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(CGFloat(5), CGFloat(5), CGFloat(5), CGFloat(5)))
            let button = UIButton.init(frame: rect)
            button.setBackgroundImage(UIImage.init(named: "label"), forState: .Normal)
            button.setTitle(titleArray[i], forState: .Normal)
            button.addTarget(self, action: Selector("labelButtonClick:"), forControlEvents: .TouchUpInside)
            buttonArray.addObject(button)
            self.addSubview(button)
        }
    }
    
    func labelButtonClick (sender: UIButton) {
        
    }
}