//
//  UIViewExtension.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/05/01.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit

extension UIView {
    
    var origin: CGPoint {
        get { return self.frame.origin }
        set { self.frame.origin = newValue }
    }
    
    var originX: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    var originY: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    var size: CGSize {
        get { return self.frame.size }
        set { self.frame.size = newValue }
    }
    
    var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    var right: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        set { self.frame.origin.x = newValue - self.frame.size.width }
    }
    
    var bottom: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height }
        set { self.frame.origin.y = newValue - self.frame.size.height }
    }
    
}