//
//  FindLocation.swift
//  On the Map
//
//  Created by Sarah on 1/11/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class FindLocation: UIViewController , MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var mapString:String?
    var mediaURL:String?
    var longitude:Double?
    var latitude:Double?
    var firstName = ""
    var lastName = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        zoomArea()
        
    }
    
    
    @IBAction func Finish(_ sender: Any) {
        if ParseClient.sharedInstance.objectId != nil {
            updatelLocation()
        }else{
            postNewLocation()
        }
    }
    
    
    func updatelLocation() {
        if let Name = UdacityClient.sharedInstance.nickname {
            self.splitName(Name)
            let jsonBody = "{\"uniqueKey\": \"\(UdacityClient.sharedInstance.userID!)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"\(mapString!)\", \"mediaURL\": \"\(mediaURL!)\",\"latitude\":\(latitude!), \"longitude\": \(longitude!)}"
            
            ParseClient.sharedInstance.updateStudentLocation(jsonBody) { (success, errorMessage) in
                if success {
                    self.returnToTableAndMapView()
                }else {
                    Helper.showAlert(ViewController: self, message: errorMessage!)
                }
                
            }
        }
    }
    
    func postNewLocation() {
        
        if let Name = UdacityClient.sharedInstance.nickname {
            self.splitName(Name)
            let jsonBody = "{\"uniqueKey\": \"\(UdacityClient.sharedInstance.userID!)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"\(mapString!)\", \"mediaURL\": \"\(mediaURL!)\",\"latitude\":\(latitude!), \"longitude\": \(longitude!)}"
            
            ParseClient.sharedInstance.postNewStudentLocation(jsonBody){ (success, errorMessage) in
                
                if success {
                    self.returnToTableAndMapView()
                }else {
                    Helper.showAlert(ViewController: self, message: errorMessage!)
                }
            }
        }
        
    }
    
    func splitName(_ Name : String){
        var fullName = Name.components(separatedBy: " ")
        if fullName.count > 0 {
            self.firstName = fullName.removeFirst()
            self.lastName = fullName.joined(separator: " ") }
    }
    
    func zoomArea(){
        let annotation = MKPointAnnotation()
        annotation.title = mapString!
        annotation.subtitle = mediaURL!
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self.map.addAnnotation(annotation)
        
        //zooming to location
        let coredinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coredinate, span: span)
        self.map.setRegion(region, animated: true)
        
    }
    
    
    
    func returnToTableAndMapView() {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.isHidden = false
            if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
        
    }
    
    
    
}

extension FindLocation {
    
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
    //
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) { 
        if control == view.rightCalloutAccessoryView {
            if let stringURL = view.annotation?.subtitle! , let url = URL(string: stringURL) {
                Helper.OpenURL(ViewController: self ,url: url)
                
            }
        }
    }
    
}

