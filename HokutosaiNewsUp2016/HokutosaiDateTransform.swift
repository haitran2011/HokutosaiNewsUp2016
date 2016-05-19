//
//  HokutosaiDateTransform.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/24.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class HokutosaiDateTransform : DateTransform {
    
    static let format = "yyyy-MM-dd HH:mm:ss Z"
    private static var _dateFormatter: NSDateFormatter?
    
    static var dateFormatter: NSDateFormatter {
        guard let formatter = _dateFormatter else {
            let newFormatter = NSDateFormatter()
            newFormatter.dateFormat = format
            self._dateFormatter = newFormatter
            return newFormatter
        }
        
        return formatter
    }
    
    static func transformFromString(dateString: String) -> NSDate? {
        return dateFormatter.dateFromString(dateString)
    }
    
    override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateString = value as? String {
            return HokutosaiDateTransform.dateFormatter.dateFromString(dateString)
        }
        
        return nil
    }
    
}

extension NSDate {
    
    public static func dateFromString(dateString: String , format: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
    
    public static func stringFromDate(date: NSDate, format: String) -> String {
        let formatter = NSDateFormatter()
        
        formatter.locale = NSLocale(localeIdentifier: NSLocaleLanguageCode)
        formatter.dateFormat = format
        
        return formatter.stringFromDate(date)
    }
    
    public func stringElapsedTime() -> String {
        let progress = NSDate().timeIntervalSinceDate(self)
        
        guard progress >= 0.0 else {
            return "0秒"
        }
        
        switch Int(progress) {
        case 0 ..< 60:
            return "\(Int(progress))秒"
        case 60 ..< 3600:
            return "\(Int(progress / 60.0))分"
        case 3600 ..< 86400:
            return "\(Int(progress / 3600.0))時間"
        case 86400 ..< 604800:
            return "\(Int(progress / 86400.0))日"
        default:
            return NSDate.stringFromDate(self, format: "yyyy/MM/dd HH:mm")
        }
    }
    
}
