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
    }
    
    var sc_height:CGFloat {
        get {
            return self.bounds.height
        }
    }
    
    var sc_x:CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var sc_y:CGFloat {
        get {
            return self.frame.origin.y
        }
    }
}
