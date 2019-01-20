

//
//  CollectionData.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum CollectionDataKeys : String{
    case ID = "id"
    case Handle = "handle"
    case Title = "title"
    case BodyHtml = "body_html"
    case Image = "image"
    
}


class CollectionData : NSObject {
    var id : String?
    var handle : String?
    var title : String?
    var bodyHtml : String?
    var image : ImageData?

    
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        try super.init()
        self.id = CollectionDataKeys.ID.rawValue => attributes
        self.handle = CollectionDataKeys.Handle.rawValue => attributes
        self.title = CollectionDataKeys.Title.rawValue => attributes
        self.bodyHtml = CollectionDataKeys.BodyHtml.rawValue => attributes
        do {
            self.image =  try ImageData(withAttributes: attributes?[CollectionDataKeys.Image.rawValue]?.dictionaryValue)
        } catch _ {
        }
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var collections : [CollectionData] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try CollectionData(withAttributes: dict.dictionaryValue)
                collections.append(modal)
            } catch _ {
            }
        }
        return collections as AnyObject?
    }
    
}
