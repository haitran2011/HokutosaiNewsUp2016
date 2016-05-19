//
//  Media.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/30.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class Media: Mappable {
    
    var mediaId: String?
    var sequence: UInt?
    var url: String?
    var fileName: String?
    var type: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.mediaId <- map["media_id"]
        self.sequence <- map["sequence"]
        self.url <- map["url"]
        self.fileName <- map["file_name"]
        self.type <- map["type"]
    }
    
}
