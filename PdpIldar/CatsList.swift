//
//  CatsList.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class CatsList: Object, Mappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    let catsList = List<Cat>()
    
    
    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        createdAt <- map["createdAt"]
    }
}

extension CatsList: Meta{
    static func endPoint() -> String {
        return ""
    }
}


