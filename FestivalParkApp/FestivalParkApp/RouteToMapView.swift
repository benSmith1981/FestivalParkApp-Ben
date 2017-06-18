//
//  Maps.swift
//  Habitz
//
//  Created by Ivo  Nederlof on 06-02-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class RouteToMapView : MKMapView, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var mapView = MKMapView()
    private let request = MKDirectionsRequest()
    private let locationManager = CLLocationManager()
    
    private var current = CLLocationCoordinate2D()

    var sourceCoordinates = CLLocationCoordinate2D()
    var destinationCoordinates : CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            
            if let coord = self.locationManager.location?.coordinate {
                sourceCoordinates = (coord)
            }
        }
    }
 
    func stopUpdateCoordinates() {
        locationManager.stopUpdatingLocation()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
 
    }
    
    /// Process coordinates and requests stuff
    ///
    /// - Returns: MKDirection request
    private func getDirections() -> MKDirections {
        
        if let destination = destinationCoordinates {
            
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinates, addressDictionary: nil))
        
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        }
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        return MKDirections(request: request)
    }
    
    
    
    func coordinatesToMapViewRepresentation() {
    
        let directions = getDirections()
            directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            for route in unwrappedResponse.routes {
                self.add(route.polyline)
                
                var regionRect = route.polyline.boundingMapRect
                
                let wPadding = regionRect.size.width * 0.25
                let hPadding = regionRect.size.height * 0.25
                
                //Add padding to the region
                regionRect.size.width += wPadding
                regionRect.size.height += hPadding
                
                //Center the region on the line
                regionRect.origin.x -= wPadding / 2
                regionRect.origin.y -= hPadding / 2
                
                self.setRegion(MKCoordinateRegionForMapRect(regionRect), animated: false)
                
            }
        }
    }
}
