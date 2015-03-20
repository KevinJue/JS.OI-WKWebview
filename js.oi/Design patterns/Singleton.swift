//
//  Singleton.swift
//  Design patterns Singleton, from https://github.com/hpique/SwiftSingleton
//
//  Created by Kevin Jue on 08/02/2015.
//  Copyright (c) 2015 Jue Kevin. All rights reserved.
//

import Foundation

class Singleton {
    
    class var sharedInstance: Singleton {
        struct Static {
            static let instance: Singleton = Singleton()
        }
        return Static.instance
    }
    
    init() {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(0.1 * Double(NSEC_PER_SEC))
            ), dispatch_get_main_queue()) {
                assert(self === Singleton.sharedInstance, "Only one instance of SingletonClass allowed!")
        }
    }
    
}