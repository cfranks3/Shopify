//
//  CollectsModel.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum CollectsKeys : String{
    case productId = "product_id"
  
    
}


class CollectsModel : NSObject {
    var productId : String = ""
    
    
    
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        try super.init()
        self.productId = ((CollectsKeys.productId.rawValue => attributes) ?? "")
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var collections : [CollectsModel] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try CollectsModel(withAttributes: dict.dictionaryValue)
                collections.append(modal)
            } catch _ {
            }
        }
        return collections as AnyObject?
    }
    
}
