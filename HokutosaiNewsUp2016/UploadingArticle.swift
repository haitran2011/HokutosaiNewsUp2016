//
//  UploadingArticle.swift
//  HokutosaiNewsUp2016
//
//  Created by Shuka Takakuma on 2016/05/19.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class UploadingArticle: Mappable {
    
    var title: String?
    var relatedEventId: UInt?
    var relatedShopId: UInt?
    var relatedExhibitionId: UInt?
    var isTopic: Bool = false
    var tag: String?
    var text: String?
    var medias: [Media]?
    
    init() {}
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.relatedEventId <- map["event_id"]
        self.relatedShopId <- map["shop_id"]
        self.relatedExhibitionId <- map["exhibition_id"]
        self.isTopic <- map["topic"]
        self.tag <- map["tag"]
        self.text <- map["text"]
        self.medias <- map["medias"]
    }
    
    init(other: UploadingArticle) {
        self.title = other.title
        self.relatedEventId = other.relatedEventId
        self.relatedShopId = other.relatedShopId
        self.relatedExhibitionId = other.relatedExhibitionId
        self.isTopic = other.isTopic
        self.tag = other.tag
        self.text = other.text
        self.medias = other.medias
    }
    
}