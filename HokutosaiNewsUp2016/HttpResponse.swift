//
//  HttpResponse.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/23.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import Alamofire

class HttpResponse<BodyType, ErrorType> {
    let isSuccess: Bool
    let response: Response<AnyObject, NSError>
    let model: BodyType?
    let error: ErrorType?
    
    var statusCode: Int? {
        return self.response.response?.statusCode
    }
    
    init (isSuccess: Bool, response: Response<AnyObject, NSError>, model: BodyType?, error: ErrorType?) {
        self.isSuccess = isSuccess
        self.response = response
        self.model = model
        self.error = error
    }
}