

//
//  APIConstants.swift
//
//  Copyright © 2019 Haspinder Singh. All rights reserved.
//

import Foundation

internal struct APIConstants {
    
   static let BasePath = "https://shopicruit.myshopify.com/admin/"
    static let DataKey = "data"
    static let status = "statusCode"
   static let AccessToken = "c32313df0d0ef512ca64d5b336a0d7c6"

}


internal struct APIPaths {
    static let Products = "products.json"
    static let Custom_Collections = "custom_collections.json"
    static let Collection_Details = "collects.json"
    
 }



internal struct FormatParameterKeys{
    static let Page = "page"
    static let AccessToken = "access_token"
    static let CollectionId = "collection_id"
    static let ProductIDs = "ids"

}


internal struct APIParameterConstants {
    struct User {
        static let CustomCollections = [FormatParameterKeys.Page,FormatParameterKeys.AccessToken]
        static let CollectionDetails = [FormatParameterKeys.CollectionId,FormatParameterKeys.Page,FormatParameterKeys.AccessToken]
        static let Products = [FormatParameterKeys.ProductIDs,FormatParameterKeys.Page,FormatParameterKeys.AccessToken]


}
    
   
    }

