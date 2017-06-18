//
//  Enums.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation


/// Type cell for the detailview
///
/// - name: name cell
/// - imageCollection: a collection pager as a cell
/// - description: decription view cell
/// - routeTo: button to navigation map

enum DetailType {
    case name
    case imageCollection
    case address
    case description
    case routeTo
    
    func PositionsAsInteger() -> Int {
        
        switch self {
        case .imageCollection:
            return 0
        case .name:
            return 1
        case .description:
            return 2
        case .address:
            return 3
        case .routeTo:
            return 4
        }
    }
}


/// Filter or catogories images
///
/// - festival: Pin Default Zomben black
/// - sport: Pin Blue Sport Ninja
/// - food: Pin Green Food
/// - dance: Pin Red Dance
/// - art: Pin Yellow Art

enum EventCategory {
    case festival
    case sport
    case food
    case dance
    case art
    
    // TODO: remove spaces from these strings and fix .imageset names
    func getPinIcon() -> String {
        switch self {
        case .festival:
            return "Pin Default Zomben black "
        case .sport:
            return "Pin Blue Sport Ninja"
        case .food:
            return "Pin Green Food "
        case .dance:
            return "Pin Red Dance "
        case .art:
            return "Pin Yellow Art "
        }
    }
}
