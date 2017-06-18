//
//  DataProvider.swift
//  FestivalParkApp
//
//  Created by Maya Lekova on 2/21/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataProvider {
    public static let sharedInstance = DataProvider()
    
    private init() {
    }
    
    var ref: FIRDatabaseReference!
    
    public func getFestivalsData() {
        ref = FIRDatabase.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? NSArray {
                var festivals = Festival.modelsFromDictionaryArray(array: data)
                festivals = festivals.sorted(by: { (lhs, rhs) -> Bool in
                    // In case some of the festivals is missing its dates span,
                    // we send it to the end of the list
                    guard let firstDates = lhs.dates else {
                        return false
                    }
                    guard let secondDates = rhs.dates else {
                        return true
                    }
                    return firstDates < secondDates
                })
                
                let festivalsData = ["festivals": festivals]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "gotFestivalsData"), object: self , userInfo: festivalsData)
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
    }
}
