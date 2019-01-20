//
//  APIRoutes.swift
//
//  Copyright © 2019 Haspinder Singh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias OptionalDictionary = [String : AnyObject]?
typealias OptionalSwiftJSONParameters = [String : JSON]?




infix operator => //{associativity left precedence 160}
infix operator =| //{associativity left precedence 160}
infix operator |=| //{associativity left precedence 160}

func =>(key : String, json : OptionalSwiftJSONParameters) -> String?{
    return json?[key]?.stringValue
}


func =|(key : String, json : OptionalSwiftJSONParameters) -> [JSON]?{
    return json?[key]?.arrayValue
}

func |=|(key : String, json : OptionalSwiftJSONParameters) -> Bool{
    return json?[key]?.boolValue ?? false
}


protocol StringType { var get: String { get } }
extension String: StringType { var get: String { return self } }
extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}



prefix operator ¿ //{}
prefix func ¿(value : String?) -> String {
    return value.unwrap()
}


protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : HTTPMethod { get }
}


enum API{

    
    static func mapKeysWithAnyObject(keys : [String]?,values : [AnyObject?]?) -> OptionalDictionary{
        guard let tempValues = values,let tempKeys = keys else { return nil}
        var params = [String : AnyObject]()
        for (key,value) in zip(tempKeys,tempValues) {
            if value is NSNull {
            continue
            }
            if let parameter = value as? String{
                params[key] = ¿parameter as AnyObject?
            } else {
                params[key] = value
            }
        }
        return params
    }
    
    

    enum UserEnum {
        case GetCustomCollections(page:String?)
        case GetCollectionDetails(collectionId:String?,page:String?)
        case GetCollectionProducts(productIds:String?,page : String?)

    }
    
    
    case UserAPI(value:UserEnum)

}


extension API : Router {
  
    var route : String  {
        switch self {
        case .UserAPI(let value):
            switch value {
            case .GetCustomCollections(_):
                return APIPaths.Custom_Collections
            case .GetCollectionDetails(_):
                return APIPaths.Collection_Details
            case .GetCollectionProducts(_):
                return APIPaths.Products
            }
        }}
    
    var parameters: OptionalDictionary{
    return formatParameters()
    }
    
    
    var method : HTTPMethod {
            return .get
    }
    
    var baseURL: String{
        return APIConstants.BasePath
    }
    
    
    func url() -> String {
        return baseURL + route
    }
}





extension API {
    func formatParameters() -> OptionalDictionary {
        switch self {
       
            
        case .UserAPI(let value):
            switch value{
            case .GetCustomCollections(let page):

                return API.mapKeysWithAnyObject(keys: APIParameterConstants.User.CustomCollections, values: [page as AnyObject,¿APIConstants.AccessToken as AnyObject])
            case .GetCollectionDetails(let collectionId,let page):
                return API.mapKeysWithAnyObject(keys: APIParameterConstants.User.CollectionDetails, values: [¿collectionId as AnyObject,page as AnyObject,¿APIConstants.AccessToken as AnyObject])
            case .GetCollectionProducts(let productIds,let page):
                return API.mapKeysWithAnyObject(keys: APIParameterConstants.User.Products, values: [¿productIds as AnyObject,page as AnyObject,¿APIConstants.AccessToken as AnyObject])
            }
        }

    }
    
    
    }


