//
//  LoginView.swift
//  On the Map
//
//  Created by Sarah on 12/21/18.
//  Copyright © 2018 Sarah. All rights reserved.
//

import UIKit

class LoginView: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func LogIn(_ sender: Any) {

        
         let username = emailTextField.text
         let password = passwordTextField.text
        
        if (username!.isEmpty) || (password!.isEmpty){
            Helper.showAlert(ViewController: self, message: "Please Enter the email and password")

        } else {
            
            Helper.startActivityIndicator(view: self.login)
            self.login.isEnabled = false
            let jsonBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}"
            
                UdacityClient.sharedInstance.authenticateWithViewController(self, jsonBody){(successLogin, errorMessage ) in

                        if !successLogin {
                            DispatchQueue.main.async {
                                self.login.isEnabled = true }
                            Helper.stopActivityIndicator()
                            Helper.showAlert(ViewController: self, message: errorMessage! )
                        } else {
                            Helper.stopActivityIndicator()
                            DispatchQueue.main.async {
                            self.login.isEnabled = true 
                            let controller = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                            self.present(controller, animated: true, completion: nil)
                            } }
                    }
            
        }
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        let url = URL(string: "https://auth.udacity.com/sign-up")
        Helper.OpenURL(ViewController: self, url: url!)
    }

}


extension LoginView: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

