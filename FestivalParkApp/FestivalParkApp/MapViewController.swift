//
//  MapViewController.swift
//  FestivalParkApp
//
//  Created by Christophe Delaporte on 27/02/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var festivalArray: [Festival] = []

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setZoomAndInitialLocation()
            
            //a
        NotificationCenter.default.addObserver(self,//b)
                                    selector: #selector(MapViewController.notifyObservers), //c)
                                    name: NSNotification.Name(rawValue: "gotFestivalsData"), //d)
                                    object: nil) //e)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
        DataProvider.sharedInstance.getFestivalsData()

        // Do any additional setup after loading the view.
        // Sets the navigation without back title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if self.shouldShowTutorial() {
            self.performSegue(withIdentifier: "showTutorial", sender: self)
        }
    }
    
    func shouldShowTutorial() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            defaults.synchronize()
            return true
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func notifyObservers(notification: NSNotification) {
        var festivalsDictionary: Dictionary<String,[Festival]> = notification.userInfo as! Dictionary<String, [Festival]>
        festivalArray = festivalsDictionary["festivals"]!
        showFestivalsOnMap()
    }
    
    func setZoomAndInitialLocation() {
        mapView.delegate = self
        let damSquareLocation = CLLocationCoordinate2D(latitude: 52.373, longitude: 4.893)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(damSquareLocation, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func showFestivalsOnMap() {
        for festival in festivalArray {
            let festivalMapAnnotation = FestivalMapAnnotation.init(festival: festival)
            self.mapView.addAnnotation(festivalMapAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        SVProgressHUD.dismiss()

        if let annotation = annotation as? FestivalMapAnnotation {
            let identifier = "pin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.calloutOffset = CGPoint(x: -5, y:5)
                view.image = UIImage(named: annotation.festival.getCategory().getPinIcon())
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                view.canShowCallout = true
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "pinFestivalDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "pinFestivalDetail" {
            let currentAnnotation = mapView.selectedAnnotations [0] as! FestivalMapAnnotation
            let destination = segue.destination as? DetailsFestivalTableView
            destination?.theFestival = currentAnnotation.festival
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
