//
//  NetworkResource.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/23.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkResource {
    
    let url: URLStringConvertible
    
    required init(url: URLStringConvertible) {
        self.url = url
    }
    
}

class ObjectResource<ModelType: Mappable>: NetworkResource {
    
    required init(url: URLStringConvertible) {
        super.init(url: url)
    }
    
}

class ArrayResource<ModelType: Mappable>: NetworkResource {
    
    required init(url: URLStringConvertible) {
        super.init(url: url)
    }
    
}
