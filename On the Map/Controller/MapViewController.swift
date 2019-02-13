//
//  MapViewController.swift
//  On the Map
//
//  Created by Sarah on 12/22/18.
//  Copyright © 2018 Sarah. All rights reserved.
//


import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var AllStudentsLocations = Student.StudentsInfo
    var annotations = [MKPointAnnotation]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllStudentsLocations()
    }

    
    func setLocationOnTheMap(){
        //
        for dictionary in AllStudentsLocations {
            
            if let Latitude = dictionary.latitude , let Longitude = dictionary.longitude , let FirstName = dictionary.firstName ,let LastName = dictionary.lastName , let MediaURL = dictionary.mediaURL {
                
                let lat = CLLocationDegrees(Latitude) as Double
                let long = CLLocationDegrees(Longitude) as Double
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(FirstName) \(LastName)"
                annotation.subtitle = MediaURL
                annotations.append(annotation)
            }
        }
        
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.annotations)
            Helper.stopActivityIndicator()
        }
    }
    
    
    func getAllStudentsLocations(){
        
        annotations.removeAll()
        let Annotations = self.mapView.annotations
        self.mapView.removeAnnotations(Annotations)
        self.AllStudentsLocations.removeAll()
        
        Helper.startActivityIndicator(view: self.view)
        
        ParseClient.sharedInstance.getStudentsLocations{(success,studentsLocations,errorMessage) in
            
            if success, let studentsLocations = studentsLocations{
                self.AllStudentsLocations = studentsLocations
                self.setLocationOnTheMap()
                Helper.stopActivityIndicator()
                
            } else {
                Helper.stopActivityIndicator()
                Helper.showAlert(ViewController: self, message: errorMessage!)
            }
            
        }
    }
    
    
    @IBAction func AddStudentLocation(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Segue3", sender: nil) }
    }
    
    @IBAction func Refresh(_ sender: Any) { 
        getAllStudentsLocations()
    }
    
    
    @IBAction func LogOut(_ sender: Any) {
        UdacityClient.sharedInstance.deleteSessionID { (success,errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil) }
            }else {
                Helper.showAlert(ViewController: self, message: errorMessage!)
            }
        }
    }
    
}

extension MapViewController {
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let stringURL = view.annotation?.subtitle! , let url = URL(string: stringURL) {
                Helper.OpenURL(ViewController: self ,url: url) 
                
            }
        }
    }
    
}
