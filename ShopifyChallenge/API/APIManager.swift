

//
//  APIManager.swift
//
//  Copyright © 2019 Haspinder Singh. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias APICompletion = (APIResponse) -> ()




class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    func opertationWithRequest ( withApi api : API , completion : @escaping APICompletion )  {

        httpClient.postRequest(withApi: api, success: { (data) in
            
            guard let response = data else {
                completion(APIResponse.Failure(""))
                return
            }
            let json = JSON(response)
            let responseType = APIValidation(rawValue: json[APIConstants.status].intValue)
            print(json)
            if responseType == .Failed || responseType == .NotFound {
                return
            }
            
            completion(.Success(api.handleResponse(parameters: json)))
        }) { (error) in
            completion(.Failure(error.localizedDescription))
            print(error)
        }
    }
    
    
    
    
   
}


