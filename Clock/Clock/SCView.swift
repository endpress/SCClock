//
//  SCView.swift
//  Clock
//
//  Created by Snow on 15/11/12.
//  this is my code
//  Copyright © 2015年 FYTech. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    var sc_width:CGFloat {
        get {
            return self.bounds.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var sc_height:CGFloat {
        get {
            return self.bounds.height
        }
        set {
             self.frame.size.height = newValue
        }
    }
    
    var sc_x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var sc_y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
             self.frame.origin.y = newValue
        }
    }
}
