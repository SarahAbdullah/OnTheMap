//
//  ParseConstants.swift
//  On the Map
//
//  Created by Sarah on 1/9/19.
//  Copyright © 2019 Sarah. All rights reserved.
//
extension ParseClient {
    
    // MARK: URLs
    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct Keys {
        static let Key = "key"
        static let ObjectId = "objectId"
    }
    
    struct Method {
        static let GetStudentLocation  = "/StudentLocation"
        static let UpdateStudentLocation  = "/StudentLocation/{objectId}"
    }
    
    struct ParamterKey {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        static let Where = "where"
        
    }
    
    struct ParamterValue {
        static let Limit = "100"
        static let Skip = "400"
        static let Order = "-updatedAt"
        static let Where = "{\"uniqueKey\":\"{key}\"}"
        
        
    }
    
    struct StudentLocationKey {
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let Result = "results"
    }
    
    
}
