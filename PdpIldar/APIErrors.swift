//
//  APIErrors.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 13.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation

import Alamofire

public enum Error: ErrorType {
    case Network(error: NSError)
    case JSONSerialization(error: NSError)
    case ObjectDecode(error: ErrorType)
//    case ResponseInvalid(status: Status)
    // case ObjectSerialization(reason: String)
}

extension Error {
    public func isCanceled() -> Bool {
        if case .Network(let nsError) = self where nsError.isCanceled() {
            return true
        }
        return false
    }
}


//MARK: - NSError

extension NSError {
    public func isCanceled() -> Bool {
        return domain == NSURLErrorDomain
            && code == NSURLErrorCancelled
    }
}