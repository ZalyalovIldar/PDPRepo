//
//  Cat.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class Cat: Object, Mappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var imageURL = ""
    dynamic var birthDay = ""
    dynamic var voice = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        birthDay <- map["birthDay"]
        imageURL <- map["image_url"]
        voice  <- map["cat_voice"]
    }
}

extension Cat: Meta{
    static func endPoint() -> String {
        return ""
    }
}

