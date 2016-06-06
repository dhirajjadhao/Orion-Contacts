
//
//  UtilMethods.swift
//  Orion Contacts
//
//  Created by Dhiraj Jadhao on 06/06/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit
import ReachabilitySwift



//MARK:- Internet Reachability
func isInternetAvailable() -> Bool {
    
    let reachability: Reachability
    do {
        reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
        return false
    }
    return reachability.isReachable()
}