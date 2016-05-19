//
//  Article.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/30.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import ObjectMapper

class Article: Mappable {
    
    var newsId: UInt?
    var title: String?
    var datetime: NSDate?
    var relatedEvent: EventItem?
    var relatedShop: ShopItem?
    var relatedExhibition: ExhibitionItem?
    var isTopic: Bool?
    var tag: String?
    var text: String?
    var likesCount: UInt?
    var liked: Bool?
    var medias: [Media]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.newsId <- map["news_id"]
        self.title <- map["title"]
        self.datetime <- (map["datetime"], HokutosaiDateTransform())
        self.relatedEvent <- map["related_event"]
        self.relatedShop <- map["related_shop"]
        self.relatedExhibition <- map["related_exhibition"]
        self.isTopic <- map["topic"]
        self.tag <- map["tag"]
        self.text <- map["text"]
        self.likesCount <- map["likes_count"]
        self.liked <- map["liked"]
        self.medias <- map["medias"]
    }
    
    var relatedTitle: String? {
        if let relatedEvent = self.relatedEvent, let title = relatedEvent.title {
            return title
        }
        else if let relatedShop = self.relatedShop, let title = relatedShop.name {
            return title
        }
        else if let relatedExhibition = self.relatedExhibition, let title = relatedExhibition.title {
            return title
        }
        
        return nil
    }
    
    enum RelatedDepartment {
        case Event
        case Shop
        case Exhibition
    }
    
    typealias Relation = (department: RelatedDepartment, id: UInt)
    
    var relation: Relation? {
        if let relatedEvent = self.relatedEvent, let id = relatedEvent.eventId {
            return (.Event, id)
        }
        else if let relatedShop = self.relatedShop, let id = relatedShop.shopId {
            return (.Shop, id)
        }
        else if let relatedExhibition = self.relatedExhibition, let id = relatedExhibition.exhibitionId {
            return (.Exhibition, id)
        }
        
        return nil
    }
    
}
