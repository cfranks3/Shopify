
//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ProductKeys : String{
    case Vendor = "vendor"
    case Variants = "variants"
}


class Product : NSObject {
    var id : String?
    var vendor : String?
    var title : String?
    var bodyHtml : String?
    var image : ImageData?
    var variants : [Variant]?

    
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        try super.init()
        self.id = CollectionDataKeys.ID.rawValue => attributes
        self.vendor = ProductKeys.Vendor.rawValue => attributes
        self.title = CollectionDataKeys.Title.rawValue => attributes
        self.bodyHtml = CollectionDataKeys.BodyHtml.rawValue => attributes
        self.variants = Variant.parseArrayinToModal(withAttributes: attributes?[ProductKeys.Variants.rawValue]?.arrayValue) as? [Variant]

        do {
            self.image =  try ImageData(withAttributes: attributes?[CollectionDataKeys.Image.rawValue]?.dictionaryValue)
        } catch _ {
        }
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var products : [Product] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try Product(withAttributes: dict.dictionaryValue)
                products.append(modal)
            } catch _ {
            }
        }
        return products as AnyObject?
    }
    
}
