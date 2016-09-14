//
//  APIConfiguration.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 13.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import Foundation

public struct Configuration {
    public static var baseURL: NSURL {
        return NSURL(string: "\(scheme)://\(host)\(scriptName)")!
    }
    
    private static var scheme: String {
        return useSSL ? "https" : "http"
    }
    
    private static var useSSL: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }
    
    private static var scriptName: String {
        return "/api"
    }
    
    public static var host: String {
        return "example.com"
    }
}