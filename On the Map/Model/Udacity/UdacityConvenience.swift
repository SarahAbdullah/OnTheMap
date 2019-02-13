//
//  UdacityConvenience.swift
//  On the Map
//
//  Created by Sarah on 12/28/18.
//  Copyright © 2018 Sarah. All rights reserved.
//
import UIKit
import Foundation

extension UdacityClient {
    
    func authenticateWithViewController(_ hostViewController: UIViewController,_ jsonBody: String ,completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        
        self.getSessionID(jsonBody){ (success,sessionID, userID, errorString) in
            if success {
                
                self.sessionID = sessionID
                self.userID = userID
                
                self.getPublicUserData(userID) { (success,nickname,errorString ) in
                    
                    if success {
                        if let nickname = nickname {
                            self.nickname = nickname
                        }
                    }
                    completionHandlerForAuth(success ,errorString )
                }
            }
            else{
                completionHandlerForAuth(success ,errorString )
            }
        }
    }
    
    func getSessionID(_ jsonBody : String , completionHandlerForSessionID: @escaping (_ success: Bool,_ sessionID: String?,_ userID: String?, _ errorString: String?) -> Void) {
        
        let _ = taskForPOSTMethod(Methods.AuthenticationSession ,jsonBody: jsonBody) { (result , error) in
            
            if let error = error {
                completionHandlerForSessionID(false ,nil,nil, error.localizedDescription )
            }else {
                
                if let result = result as? [String: Any] , let session = result[UdacityClient.UdacityJSONResponse.session]  as? [String: Any], let account = result[UdacityClient.UdacityJSONResponse.account]  as? [String: Any] {
                    let sessionID = session[UdacityClient.UdacityJSONResponse.id] as? String
                    let userID = account[UdacityClient.UdacityJSONResponse.key] as? String
                    completionHandlerForSessionID(true,sessionID,userID,nil)
                    
                }
                else{
                    completionHandlerForSessionID(false ,nil,nil, error!.localizedDescription)
                }
                
            }
        }
        
    }
    
    func getPublicUserData(_ userID : String!, completionHandlerForUserData: @escaping (_ success: Bool,_ nickname : String? , _ errorString: String?) -> Void) {
        
        var mutableMethod: String = Methods.getPublicUserData
        mutableMethod = substituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.UserID, value: String(UdacityClient.sharedInstance.userID!))!
        
        let _ = taskForGETMethod(mutableMethod) { (result , error) in
            
            if let error = error {
                completionHandlerForUserData(false ,nil, error.localizedDescription)
            }else {
                if let result = result as? [String: Any] {
                    let nickname = result[PublicUserData.nickname] as? String
                    completionHandlerForUserData(true,nickname,nil)
                }
                else {
                    completionHandlerForUserData(false ,nil, error!.localizedDescription )
                }
            }
        }
    }
    
    
    func deleteSessionID(_ completionHandlerForDeleteSessionID: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        
        let _ = taskForDELETEMethod(Methods.AuthenticationSession ) { (result , error) in
            
            if let error = error {
                completionHandlerForDeleteSessionID(false , error.localizedDescription)
            }else {
                completionHandlerForDeleteSessionID(true ,nil)
            }
        }
        
    }
    
    
    
}


