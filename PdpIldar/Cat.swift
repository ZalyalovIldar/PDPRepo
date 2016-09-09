//
//  Cat.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import RealmSwift

class Cat: Object {
    dynamic var name = ""
    dynamic var image_id = ""
    dynamic var format: AnyObject?
    dynamic var type = ""
//    dynamic var owner: Owner?
    dynamic var birthDay = NSDate()
    dynamic var voice = ""
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
