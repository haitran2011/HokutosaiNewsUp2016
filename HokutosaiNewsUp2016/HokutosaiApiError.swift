//
//  HokutosaiApiError.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/23.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class HokutosaiApiError : Mappable {
    
    var code: Int?
    var cause: String?
    var message: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.code <- map["error.code"]
        self.cause <- map["error.cause"]
        self.message <- map["error.message"]
    }
    
}