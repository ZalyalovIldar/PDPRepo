//
//  CatsList.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation
import RealmSwift

class CatsList: Object {
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    let catsList = List<Cat>()
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
