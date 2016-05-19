//
//  HokutosaiApiStatus.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/05/13.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class HokutosaiApiStatus: Mappable {
    
    var statusCode: Int?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.statusCode <- map["status_code"]
    }
    
}