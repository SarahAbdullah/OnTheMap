//
//  StudentInformation.swift
//  On the Map
//
//  Created by Sarah on 1/9/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import Foundation

// this is the StudentInformation struct
struct StudentInformation {
    var objectId: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var createdAt: String?
    var updatedAt: String?
    
    
    // MARK: Initializers
    
    // construct a StudentLocation from a dictionary
    init(dictionary: [String:AnyObject]) {
        objectId = dictionary[ParseClient.StudentLocationKey.ObjectId] as? String
        uniqueKey = dictionary[ParseClient.StudentLocationKey.UniqueKey] as? String
        firstName = dictionary[ParseClient.StudentLocationKey.FirstName] as? String
        lastName = dictionary[ParseClient.StudentLocationKey.LastName] as? String
        mapString = dictionary[ParseClient.StudentLocationKey.MapString] as? String
        mediaURL = dictionary[ParseClient.StudentLocationKey.MediaURL] as? String
        latitude = dictionary[ParseClient.StudentLocationKey.Latitude] as? Double
        longitude = dictionary[ParseClient.StudentLocationKey.Longitude] as? Double
        createdAt = dictionary[ParseClient.StudentLocationKey.CreatedAt] as? String
        updatedAt = dictionary[ParseClient.StudentLocationKey.UpdatedAt] as? String
    }
    
    static func StudentLocationFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var location = [StudentInformation]()
        
        for result in results {
            location.append(StudentInformation(dictionary: result))
        }
        
        return location
    }
    
}
