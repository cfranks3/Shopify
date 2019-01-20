//
//
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias HttpClientSuccess = (AnyObject?) -> ()
typealias HttpClientFailure = (NSError) -> ()
typealias HttpClientProgress = (AnyObject?) -> ()
typealias HttpClientImageFailure = (String) -> ()

class HTTPClient {
    
    
    func postRequest(withApi api : API  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        let params = api.parameters
        let fullPath = api.url()
        let method = api.method
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
//        if api.route == APIPaths.GetRFIDDetails{
//            guard let keyo = api.formatParameters()?.values.first as? String else {return}
//            let path = ¿(api.formatParameters()?.keys.first) + "=" + keyo
//            fullPath = fullPath + "?" + path
//        }
        
        
        Alamofire.request(fullPath, method: method, parameters: params, headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(let data):
                success(data as AnyObject?)
            case .failure(let error):
                failure(error as NSError)
            }
        }
        
        
    }
    
        }
