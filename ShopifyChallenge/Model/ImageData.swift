
//
//  ImageData.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum ImageKeys : String{
    case Source = "src"
    
}


class ImageData : NSObject {
    var src : String?
    
    
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        try super.init()
        self.src = ImageKeys.Source.rawValue => attributes
    }
    
    
    override init() {
        super.init()
    }
}
