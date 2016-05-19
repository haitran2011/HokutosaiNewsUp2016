//
//  HokutosaiApiEndpoint.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/23.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation

class HokutosaiApiEndpoint<ResourceType: NetworkResource>: Endpoint<ResourceType, HokutosaiApiError> {
    
    let baseUrl = "https://api.hokutosai.tech/2016"
    let requiredAccount: Bool
    
    init (basePath: String, requiredAccount: Bool = true) {
        self.requiredAccount = requiredAccount
        super.init(baseUrl: baseUrl, path: basePath)
    }
    
    init (basePath: String, path: String, requiredAccount: Bool = true) {
        self.requiredAccount = requiredAccount
        super.init(baseUrl: baseUrl, path: basePath + path)
    }
    
}

extension HokutosaiApi {
    
    class News {
        
        static let basePath = "/news"
        
        class Timeline: HokutosaiApiEndpoint<ArrayResource<Article>> {
            init() { super.init(basePath: basePath, path: "/timeline") }
        }
        
        /*
        class Topics: HokutosaiApiEndpoint<ArrayResource<TopicNews>> {
            init() { super.init(basePath: basePath, path: "/topics", requiredAccount: false) }
        }
        */
        
        class Details: HokutosaiApiEndpoint<ObjectResource<Article>> {
            init(newsId: UInt) { super.init(basePath: basePath, path: "/\(newsId)/details") }
        }
        
        /*
        class Likes: HokutosaiApiEndpoint<ObjectResource<LikeResult>> {
            init(newsId: UInt) { super.init(basePath: basePath, path: "/\(newsId)/likes") }
        }
        */
        
        class PostOnlyArticle: HokutosaiApiEndpoint<ObjectResource<UploadingArticle>> {
            init() { super.init(basePath: basePath, path: "/article") }
        }
            
        class DeleteOnlyArticle: HokutosaiApiEndpoint<ObjectResource<HokutosaiApiStatus>> {
            init(newsId: UInt) { super.init(basePath: basePath, path: "/\(newsId)") }
        }
        
    }
    
    /*
    class Events {
        
        static let basePath = "/events"
        
        class Events: HokutosaiApiEndpoint<ArrayResource<Event>> {
            init() { super.init(basePath: basePath) }
        }
        
        class Schedules: HokutosaiApiEndpoint<ArrayResource<Schedule>> {
            init() { super.init(basePath: basePath, path: "/schedules") }
        }
        
        class Topics: HokutosaiApiEndpoint<ArrayResource<TopicEvent>> {
            init() { super.init(basePath: basePath, path: "/topics", requiredAccount: false) }
        }
        
        class Details: HokutosaiApiEndpoint<ObjectResource<Event>> {
            init(eventId: UInt) { super.init(basePath: basePath, path: "/\(eventId)/details") }
        }
        
        class Likes: HokutosaiApiEndpoint<ObjectResource<LikeResult>> {
            init(eventId: UInt) { super.init(basePath: basePath, path: "/\(eventId)/likes") }
        }
        
    }
    */
    
    /*
    class Shops {
        
        static let basePath = "/shops"
        
        class All: HokutosaiApiEndpoint<ArrayResource<Shop>> {
            init() { super.init(basePath: basePath) }
        }
        
        class One: HokutosaiApiEndpoint<ObjectResource<Shop>> {
            init(shopId: UInt) { super.init(basePath: basePath, path: "/\(shopId)") }
        }
        
        class Details: HokutosaiApiEndpoint<ObjectResource<DetailedShop>> {
            init(shopId: UInt) { super.init(basePath: basePath, path: "/\(shopId)/details") }
        }
        
        class Assessments: HokutosaiApiEndpoint<ObjectResource<AssessmentList>> {
            init(shopId: UInt) { super.init(basePath: basePath, path: "/\(shopId)/assessments") }
        }
        
        class Assessment: HokutosaiApiEndpoint<ObjectResource<MyAssessment>> {
            init(shopId: UInt) { super.init(basePath: basePath, path: "/\(shopId)/assessment") }
        }
        
        class Likes: HokutosaiApiEndpoint<ObjectResource<LikeResult>> {
            init(shopId: UInt) { super.init(basePath: basePath, path: "/\(shopId)/likes") }
        }
        
        class AssessmentReport: HokutosaiApiEndpoint<ObjectResource<HokutosaiApiStatus>> {
            init(assessmentId: UInt) { super.init(basePath: basePath, path: "/assessment/\(assessmentId)/report") }
        }
        
    }
    */
    
    /*
    class Exhibitions {
        
        static let basePath = "/exhibitions"
        
        class All: HokutosaiApiEndpoint<ArrayResource<Exhibition>> {
            init() { super.init(basePath: basePath) }
        }
        
        class One: HokutosaiApiEndpoint<ObjectResource<Exhibition>> {
            init(exhibitionId: UInt) { super.init(basePath: basePath, path: "/\(exhibitionId)") }
        }
        
        class Details: HokutosaiApiEndpoint<ObjectResource<DetailedExhibition>> {
            init(exhibitionId: UInt) { super.init(basePath: basePath, path: "/\(exhibitionId)/details") }
        }
        
        class Assessments: HokutosaiApiEndpoint<ObjectResource<AssessmentList>> {
            init(exhibitionId: UInt) { super.init(basePath: basePath, path: "/\(exhibitionId)/assessments") }
        }
        
        class Assessment: HokutosaiApiEndpoint<ObjectResource<MyAssessment>> {
            init(exhibitionId: UInt) { super.init(basePath: basePath, path: "/\(exhibitionId)/assessment") }
        }
        
        class Likes: HokutosaiApiEndpoint<ObjectResource<LikeResult>> {
            init(exhibitionId: UInt) { super.init(basePath: basePath, path: "/\(exhibitionId)/likes") }
        }
        
        class AssessmentReport: HokutosaiApiEndpoint<ObjectResource<HokutosaiApiStatus>> {
            init(assessmentId: UInt) { super.init(basePath: basePath, path: "/assessment/\(assessmentId)/report") }
        }
        
    }
    */
    
    /*
    class Accounts {
        
        static let basePath = "/accounts"
        
        class New: HokutosaiApiEndpoint<ObjectResource<HokutosaiAccount>> {
            init() { super.init(basePath: basePath, path: "/new", requiredAccount: false) }
        }
        
    }
    */
    
    /*
    class Assessments {
        
        static let basePath = "/assessments"
        
        class ReportCauses: HokutosaiApiEndpoint<ArrayResource<AssessmentReportCause>> {
            init() { super.init(basePath: basePath, path: "/reports/causes") }
        }
        
    }
    */
    
}