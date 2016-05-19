//
//  Color.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/28.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import UIKit

extension UIColor {

    class func trueColor(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8 = 255) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    class func grayscale(shade: UInt8, alpha: UInt8 = 255) -> UIColor {
        let sh = CGFloat(shade)
        return UIColor(red: sh / 255.0, green: sh / 255.0, blue: sh / 255.0, alpha: CGFloat(alpha) / 255.0)
    }

}