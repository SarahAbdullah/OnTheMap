//
//  ParseConvenience.swift
//  On the Map
//
//  Created by Sarah on 1/9/19.
//  Copyright © 2019 Sarah. All rights reserved.
//
import Foundation
extension ParseClient {
    
    
    
    func getStudentsLocations(_ completionHandlerForStudentsLocations: @escaping (_ success: Bool,_ studentsLocations: [StudentInformation]?, _ errorString: String?) -> Void) {
        
        let Parameters = [ParseClient.ParamterKey.Limit:ParseClient.ParamterValue.Limit , ParseClient.ParamterKey.Order:ParseClient.ParamterValue.Order] as [String : AnyObject]
        
        let _ = taskForGETMethod(ParseClient.Method.GetStudentLocation ,Parameters) { (result , error) in
            
            if let error = error {
                completionHandlerForStudentsLocations(false ,nil,error.localizedDescription)
            }else {
                if let result = result![ParseClient.StudentLocationKey.Result] as? [[String:AnyObject]] {
                    let studentsLocations = StudentInformation.StudentLocationFromResults(result)
                    completionHandlerForStudentsLocations(true ,studentsLocations,nil)
                }
                else{
                    completionHandlerForStudentsLocations(false ,nil, error!.localizedDescription)
                }
                
            }
        }
        
    }
    
    
    func postNewStudentLocation(_ jsonBody : String , _ completionHandlerForNewStudentLocation: @escaping (_ success: Bool , _ errorString: String?) -> Void) {
        
        let _ = taskForPOSTMethod(ParseClient.Method.GetStudentLocation ,jsonBody: jsonBody) { (result , error) in
            
            if let error = error {
                completionHandlerForNewStudentLocation(false ,error.localizedDescription)
            }else {
                if result != nil {
                    completionHandlerForNewStudentLocation(true ,nil)
                }
                else{
                    completionHandlerForNewStudentLocation(false,error!.localizedDescription)
                }
                
            }
        }
    }
    
    func updateStudentLocation(_ jsonBody : String , _ completionHandlerForUpdateStudentLocation: @escaping (_ success: Bool , _ errorString: String?) -> Void) {
        
        var mutableMethod = ParseClient.Method.UpdateStudentLocation
        mutableMethod = substituteKeyInMethod(mutableMethod, key: ParseClient.Keys.ObjectId, value: self.objectId!)!
        
        let _ = taskForPUTMethod(mutableMethod,jsonBody: jsonBody) { (result , error) in
            
            if let error = error {
                completionHandlerForUpdateStudentLocation(false ,error.localizedDescription)
            }else {
                if result != nil {
                    completionHandlerForUpdateStudentLocation(true ,nil)
                }
                else{
                    completionHandlerForUpdateStudentLocation(false,error!.localizedDescription)
                }
                
            }
        }
    }
    
    
}

