//
//  ShopItem.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/30.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class ShopItem: Mappable {
    
    var shopId: UInt?
    var name: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.shopId <- map["shop_id"]
        self.name <- map["name"]
    }
    
}