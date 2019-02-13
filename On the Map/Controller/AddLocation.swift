//
//  Add Location.swift
//  On the Map
//
//  Created by Sarah on 1/11/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import UIKit
import MapKit

class AddLocation: UIViewController {

    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var link: UITextField!
    var longitude :Double = 0.0
    var latitude :Double = 0.0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    
    @IBAction func FindLocation(_ sender: Any) {
        
        if location.text != "" && link.text != "" {
            if let Link = link.text ,(Link.contains("https://") || Link.contains("http://")){
                Helper.startActivityIndicator(view: self.view)
                
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = location.text
                let search = MKLocalSearch(request: request)
                search.start { (respone, error) in
                    if error != nil {
                        Helper.stopActivityIndicator()
                        Helper.showAlert(ViewController: self, message: "Your location is not found ")
                    }else{
                        Helper.stopActivityIndicator()
                        self.longitude = (respone?.boundingRegion.center.longitude)!
                        self.latitude = (respone?.boundingRegion.center.latitude)!
                        self.performSegue(withIdentifier: "Segue1", sender: nil)
                    }
                }
            } else {
                Helper.showAlert(ViewController: self, message: "Your Link must contain http//")
            }
        }else{
            Helper.showAlert(ViewController: self, message: "Please Enter your Location and your Link!")
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.isHidden = false
            if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue1"{
            let viewController = segue.destination as! FindLocation
            viewController.mapString = location.text
            viewController.mediaURL = link.text
            viewController.latitude = self.latitude
            viewController.longitude = self.longitude
        }
    }
 
}
