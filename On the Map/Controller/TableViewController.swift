//
//  TableViewController.swift
//  On the Map
//
//  Created by Sarah on 1/11/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet var Table: UITableView!
    
    var AllStudentsLocations = Student.StudentsInfo
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllStudentsLocations()
    }
    
    func getAllStudentsLocations(){
        self.AllStudentsLocations.removeAll()
        
        Helper.startActivityIndicator(view: self.view)
        
        ParseClient.sharedInstance.getStudentsLocations{(success,studentsLocations,errorMessage) in
            
            if success, let studentsLocations = studentsLocations {
                self.AllStudentsLocations = studentsLocations
                Helper.stopActivityIndicator()
                DispatchQueue.main.async {
                    self.Table.reloadData()
                }
            } else {
                Helper.stopActivityIndicator()
                Helper.showAlert(ViewController: self, message: errorMessage!)
            }
        }
    }
    //AddStudentLocation
    
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

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllStudentsLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        let student = AllStudentsLocations[(indexPath as NSIndexPath).row]
        if let FN = student.firstName {
            if let LN = student.lastName , let MU = student.mediaURL{
            cell.Name.text = "\(FN) \(LN)"
            cell.URL.text = "\(MU)"
            }else{
                cell.Name.text = "\(FN)"
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = AllStudentsLocations[(indexPath as NSIndexPath).row]
        if let mediaURL = selectedCell.mediaURL,let url = URL(string: mediaURL){
            Helper.OpenURL(ViewController: self ,url: url)
        }
    }
  
}

