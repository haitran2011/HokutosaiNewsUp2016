//
//  EventItem.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/30.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class EventItem: Mappable {
    
    var eventId: UInt?
    var title: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.eventId <- map["event_id"]
        self.title <- map["title"]
    }
    
}
