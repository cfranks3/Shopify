//
//  APIResponse.swift
//
//  Copyright © 2019 Haspinder Singh. All rights reserved.
//

import Foundation
import SwiftyJSON


extension API{
    func handleResponse(parameters : JSON?) -> AnyObject? {
        switch self {
        case .UserAPI(value: let value):
            switch value{
            case .GetCustomCollections(_):
                return CollectionData.parseArrayinToModal(withAttributes: parameters?.dictionaryValue["custom_collections"]?.arrayValue)
            case .GetCollectionDetails(_):
                return CollectsModel.parseArrayinToModal(withAttributes: parameters?.dictionaryValue["collects"]?.arrayValue)
            case .GetCollectionProducts(_):
                return Product.parseArrayinToModal(withAttributes: parameters?.dictionaryValue["products"]?.arrayValue)
            }
        }
        }
    
}

enum APIValidation : Int{
    case Success = 200
    case SuccessFul = 201
    case ServerIssue = 500
    case Failed = 400
    case NotFound = 404
    case TokenInvalid = 401
    case None
}


enum APIResponse {
    case Success(AnyObject?)
    case Failure(String?)
}
