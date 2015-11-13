//
//  SCColor.swift
//  Clock
//
//  Created by ZhangSC on 15/11/12.
//  Copyright © 2015年 FYTech. All rights reserved.
//

import UIKit

extension UIColor {

   static func sc_init(r r:Int, g:Int, b:Int, alpha:Double) ->UIColor? {
        guard checkRGB(r, g, b) == true else {return nil}
        return UIColor.init(red: CGFloat(Double(r)/255.0), green: CGFloat(Double(g)/255.0), blue: CGFloat(Double(b)/255.0), alpha: CGFloat(alpha))
    }
    
   static func checkRGB(r:Int, _ g:Int, _ b:Int) ->Bool {
        if (r < 0 || r > 255) { return false }
        if (g < 0 || g > 255) { return false }
        if (b < 0 || b > 255) { return false }
        return true
    }
}
