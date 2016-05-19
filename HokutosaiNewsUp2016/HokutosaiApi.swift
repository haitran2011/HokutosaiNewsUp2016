//
//  HokutosaiApi.swift
//  HokutosaiApp
//
//  Created by Shuka Takakuma on 2016/04/23.
//  Copyright © 2016年 Shuka Takakuma. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HokutosaiApi {
    
    private class AuthorizationHeader {
    
        static let name = "Authorization"
        private static let apiUserId = "management-ios-app"
        private static let apiAccessToken = "oU5KMLXjQRpnDvRxxgP39PkKXmmm3TxExvIq3BA3uBAeJS6FyYflq3kFA5XYTghN"
        
        class func generate(account: HokutosaiAccount?) -> String {
            var value = "user_id=\(apiUserId),access_token=\(apiAccessToken)"
            
            if let account = account {
                value += ",account_id=\(account.accountId),account_pass=\(account.accountPass)"
            }
            
            return value
        }
        
    }
    
    // Management User Only
    private class HokutosaiAccount {
        
        let accountId: String = "management-ios"
        let accountPass: String = "gq4r29JPZ2EbkpAvRp9wpaDCfSrCV9OtOCfWyG4YXBNvCXfhI685bs7GIiG6W5NR"
        
        static let sharedAccountForManager = HokutosaiAccount()
        private init() {}
        
    }
    
    class func GET<ModelType: Mappable, ResourceType: ArrayResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<[ModelType], HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.GET, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func GET<ModelType: Mappable, ResourceType: ObjectResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<ModelType, HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.GET, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func POST<ModelType: Mappable, ResourceType: ArrayResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<[ModelType], HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.POST, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func POST<ModelType: Mappable, ResourceType: ObjectResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<ModelType, HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.POST, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func PUT<ModelType: Mappable, ResourceType: ArrayResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<[ModelType], HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.PUT, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func PUT<ModelType: Mappable, ResourceType: ObjectResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<ModelType, HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.PUT, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func DELETE<ModelType: Mappable, ResourceType: ArrayResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<[ModelType], HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.DELETE, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    class func DELETE<ModelType: Mappable, ResourceType: ObjectResource<ModelType>>(
        endpoint: HokutosaiApiEndpoint<ResourceType>,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<ModelType, HokutosaiApiError>) -> Void))
    {
        HokutosaiApi.call(.DELETE, url: endpoint.url, requiredAccount: endpoint.requiredAccount, parameters: parameters, encoding: encoding, headers: headers, recipient: recipient)
    }
    
    private class func call<ModelType: Mappable, ErrorType: Mappable>(
        method: Alamofire.Method,
        url: URLStringConvertible,
        requiredAccount: Bool,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<[ModelType], ErrorType>) -> Void))
    {
        let account: HokutosaiAccount? = requiredAccount ? HokutosaiAccount.sharedAccountForManager : nil
        
        let requestHeaders = generateHeaders(headers, account: account)
        REST.call(method, url: url, parameters: parameters, encoding: encoding, headers: requestHeaders, recipient: recipient)
    }
    
    private class func call<ModelType: Mappable, ErrorType: Mappable>(
        method: Alamofire.Method,
        url: URLStringConvertible,
        requiredAccount: Bool,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        recipient: ((HttpResponse<ModelType, ErrorType>) -> Void))
    {
        let account: HokutosaiAccount? = requiredAccount ? HokutosaiAccount.sharedAccountForManager : nil

        let requestHeaders = generateHeaders(headers, account: account)
        REST.call(method, url: url, parameters: parameters, encoding: encoding, headers: requestHeaders, recipient: recipient)
    }
    
    private class func generateHeaders(headers: [String: String]?, account: HokutosaiAccount?) -> [String: String] {
        var requestHeaders = [String: String]()
        
        if let headers = headers {
            requestHeaders += headers
        }
        
        requestHeaders[AuthorizationHeader.name] = AuthorizationHeader.generate(account)
        
        return requestHeaders
    }
    
}

func += <KeyType, ValueType> (inout left: [KeyType: ValueType], right: [KeyType: ValueType]) {
    for (key, value) in right {
        left.updateValue(value, forKey: key)
    }
}