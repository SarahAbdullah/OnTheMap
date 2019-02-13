//
//  Helper.swift
//  On the Map
//
//  Created by Sarah on 1/10/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

struct Helper {
    
    static var activityIndicator = UIActivityIndicatorView()
    static var flag = false
    
    static func startActivityIndicator(view:UIView ){
        DispatchQueue.main.async {
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating() }
    }
    
    
    static func stopActivityIndicator(){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()}
        
    }
    
    static func showAlert( ViewController : UIViewController, message: String) {
        DispatchQueue.main.async {
            var title = ""
            if flag {
                title = "Invalid Website"
            }else{
                title = "Alert"
                
            }
            let Alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            ViewController.present(Alert, animated: true) }
    }
    
    static func OpenURL(ViewController: UIViewController ,url: URL ){
        let stringURL = url.absoluteString
        if stringURL.contains("https://") || stringURL.contains("http://") {
            let SafariViewController = SFSafariViewController(url: url)
            DispatchQueue.main.async{
                ViewController.present(SafariViewController, animated: true, completion: nil) }
        } else{
            DispatchQueue.main.async{
                self.flag = true
                Helper.showAlert(ViewController: ViewController, message: "Can't open this website" )
                self.flag = false
                
            }
        }
        
    }
    
    
}
