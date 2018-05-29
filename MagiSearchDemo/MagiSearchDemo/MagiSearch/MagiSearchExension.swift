//
//  MagiSearchExension.swift
//  MagiSearchDemo
//
//  Created by 安然 on 2018/5/28.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

// MARK: - frame设置扩展
public extension UIView {
    
    
    var magi_x:CGFloat{
        get{
            return self.frame.origin.x
        }
        
        set{
            self.frame.origin.x = newValue
        }
    }
    
    var magi_y:CGFloat{
        get{
            return self.frame.origin.y
        }
        
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var magi_width:CGFloat{
        get{
            return self.frame.size.width
        }
        
        set{
            self.frame.size.width = newValue
        }
    }
    
    var magi_height:CGFloat{
        get{
            return self.frame.size.height
        }
        
        set{
            self.frame.size.height = newValue
        }
    }
    
    var magi_size:CGSize{
        get{
            return self.frame.size
        }
        
        set{
            self.frame.size = newValue
        }
    }
    
    var magi_centerX:CGFloat{
        get{
            return self.center.x
        }
        
        set{
            self.center.x = newValue
        }
    }
    
    var magi_centerY:CGFloat{
        get{
            return self.center.y
        }
        
        set{
            self.center.y = newValue
        }
    }
    
    
}



extension UIColor {
    
    convenience init(magihexString: String) {
        
        let hex = magihexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
