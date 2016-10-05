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
    
    class func get <T:Object where T:Mappable,T:Meta> (type:T.Type,success:()->Void,fail:(error:NSError)->Void)->Void {
        Alamofire.request(Method.GET, type.url())
            .responseArray { (response: Response<[T], NSError>) in
                switch response.result {
                case .Success(let item):
                    do {
                        let realm = try Realm()
                        try realm.write {
                            for item in items {
                                realm.add(item, update: true)
                            }
                        } catch let error as NSError {
                            fail(error:error)
                        }
                        success()
                        case .Failure(let error):
                        fail(error:error)
                    }
                }
        }
        
       class func post <T:Object where T:Mappable,T:Meta> (type:T.Type,success:()->Void,fail:(error:NSError)->Void)->Void {
            Alamofire.request(Method.POST, type.url())
                .responseArray { (response: Response<[T], NSError>) in
                    switch response.result {
                            case .Failure(let error):
                            fail(error:error)
                        }
                    }
            }
        
    class func cancelAllRequestForViewController(viewControllerName: String) {
        Alamofire.Manager.sharedInstance.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach {
                if $0.taskDescription == viewControllerName {
                    $0.cancel()
                }
            }
            uploadTasks.forEach {
                if $0.taskDescription == viewControllerName {
                    $0.cancel()
                }
            }
            downloadTasks.forEach {
                if $0.taskDescription == viewControllerName {
                    $0.cancel()
                }
            }
        }
    }
    
}
