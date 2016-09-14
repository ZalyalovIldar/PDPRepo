//
//  APIManager.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import Alamofire

protocol Meta {
    static func endPoint() -> String
}

class APIManager: NSObject {
    
    class var sharedInstance: APIManager {
        struct Static {
            static var instance: APIManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = APIManager()
        }
        return Static.instance!
    }
    
    func getCatsList(requestResultBlock:(AnyObject) -> ()){
        
        Alamofire.request(.GET, "http://thecatapi.com/api/images/get?format=xml&results_per_page=20", parameters: nil, encoding: ParameterEncoding.URL).responsePropertyList { response in
            
            if let error = response.result.error {
                print("Error: \(error)")
    
                // parsing the data to an array
            } else if let array = response.result.value as? [[String: String]] {
               requestResultBlock(array)
            }
        }
    }
    
}
