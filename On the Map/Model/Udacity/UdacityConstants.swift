//UdacityConstants.swift
extension UdacityClient {
    
    // MARK: URLs
    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "onthemap-api.udacity.com"
        static let ApiPath = "/v1"
    }
    
    // MARK: Methods
    struct Methods {
        static let AuthenticationSession = "/session"
        static let  getPublicUserData = "/users/{id}"
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
    }

    struct UdacityJSONResponse {
       static let account = "account"
       static let key = "key"
       static let session = "session"
       static let id = "id"
    }

    struct PublicUserData {
        static let nickname = "nickname"
    }
    
}
