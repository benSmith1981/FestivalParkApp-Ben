//
//  File.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 28-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Foundation

struct GlobalParams {
    
    // Main Settings
    struct main {
        static var title = "Amsterdam Events"
    }
    // Navigation Settings
    struct navigation {
 
        static var barTintColor = UIColor(red: 10.0/255.0, green: 161.0/255.0, blue: 11.0/255.0, alpha: 1.0)
    }
    
    struct tabBar {
        static let tabTextPosition = UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)

    }
}
