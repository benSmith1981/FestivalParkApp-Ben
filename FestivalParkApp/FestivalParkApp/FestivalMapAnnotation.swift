//
//  FestivalMapAnnotation.swift
//  FestivalParkApp
//
//  Created by Christophe Delaporte on 27/02/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation
import MapKit

class FestivalMapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var festival: Festival
    
    init(festival: Festival) {
        self.festival = festival
        self.title = festival.title
        self.subtitle = festival.details?.en?.shortdescription
        
        if let latString = festival.location?.latitude,
            let longString = festival.location?.longitude {
            
            let newlatString = latString.replacingOccurrences(of: ",",with: ".", options: .literal, range: nil)
            let newlongString = longString.replacingOccurrences(of: ",",with: ".", options: .literal, range: nil)
            
            let lat = Double(newlatString)
            let long = Double(newlongString)
            
            self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            
        } else {
            
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
    
        super.init()
    }
    
}

