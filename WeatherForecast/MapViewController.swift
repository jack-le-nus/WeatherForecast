//
//  MapViewController.swift
//  WeatherForecast
//
//  Created by Jack Le on 21/4/17.
//  Copyright © 2017 Jack Le. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var specifiedLocation : CLLocationCoordinate2D = CLLocationCoordinate2D()
    var locationManager:CLLocationManager!
    
    override var nibName: String? {
        get {
            return "MapViewController"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtAddress.delegate = self;
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let address = txtAddress.text;
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                self.annotateMap(placemark.location!.coordinate);
            }
            else {
                self.displayErrorMsg()
            }
        })
        textField.resignFirstResponder()
        return true
    }
    
    func displayErrorMsg() {
        let alert=UIAlertController(title: "Location Not Found!", message: "Please enter another address", preferredStyle: UIAlertControllerStyle.alert);
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil);
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            self.annotateMap(lastLocation.coordinate);
            
            locationManager.stopUpdatingLocation();
            
        }
        else {
            self.displayErrorMsg()
        }
    }
    
    func annotateMap (_ newCoordinate : CLLocationCoordinate2D) {
        // set region on the map
        self.specifiedLocation = newCoordinate
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let myLocation:CLLocationCoordinate2D = newCoordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan)
        self.mapView.setRegion(theRegion, animated: true)
        self.mapView.mapType = MKMapType.standard
        // add annotation
        let myHomePin = MKPointAnnotation()
        myHomePin.coordinate = newCoordinate
        myHomePin.title = txtAddress.text
        self.mapView.addAnnotation(myHomePin)
    }

    override func viewWillDisappear(_ animated: Bool) {
        WeatherForecastManager.sharedInstance.getWeatherForecast(lat:specifiedLocation.latitude, lon:specifiedLocation.longitude, completionHandler: { (weatherResponse) in
            
        })
    }
}
