//
//  Variant.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON


enum VariantKeys : String{
    case quantity = "inventory_quantity"
}


class Variant : NSObject {
    var quantity : Int?
    
    
    
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        try super.init()
        self.quantity = Int((VariantKeys.quantity.rawValue => attributes) ?? "0")
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var variants : [Variant] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try Variant(withAttributes: dict.dictionaryValue)
                variants.append(modal)
            } catch _ {
            }
        }
        return variants as AnyObject?
    }
    
}
