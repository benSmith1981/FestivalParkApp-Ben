//
//  RouteMapViewController.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 02-03-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class RouteMapViewController: UIViewController, MKMapViewDelegate {

    var mapView: RouteToMapView!
    var toGoogleMapsButton : UIButton!
    var destinationCoordinate = CLLocationCoordinate2D()
    var sourceCoordinate = CLLocationCoordinate2D()
    var selectedFestival : Festival?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Helvetica-bold", size: 15)!,
            NSForegroundColorAttributeName : UIColor.white]
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()

        /// load festival coordinates
        if let lat = (selectedFestival?.location?.latitude)?.replaceCommaForPoint(of: ",", changeWith: ".")
            ,let long = (selectedFestival?.location?.longitude)?.replaceCommaForPoint(of: ",", changeWith: ".") {
        
            destinationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        configureMapView()
        self.title = selectedFestival?.title?.uppercased()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
 
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        mapView.stopUpdateCoordinates()
    }
    
    func configureMapView() {
        
        mapView = RouteToMapView(frame: view.frame)
        mapView.destinationCoordinates = destinationCoordinate
        mapView.coordinatesToMapViewRepresentation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userLocation.title = "Me"
        mapView.tintColor = GlobalParams.navigation.barTintColor
        view.addSubview(mapView)
        print(mapView.sourceCoordinates)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        SVProgressHUD.dismiss()
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = GlobalParams.navigation.barTintColor
        renderer.lineWidth = 5
        return renderer
    }

}
