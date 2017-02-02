//
//  ResponseResultsUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseResultsUserModel: Mappable {
    
    var company: Int?
    var email: String?
    var firstName: String?
    var id: Int?
    var lastName: String?
    var userPermissions: [ResponseResultsUserPermissionUserModel]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.company <- map["company"]
        self.email <- map["email"]
        self.firstName <- map["first_name"]
        self.id <- map["id"]
        self.lastName <- map["last_name"]
        self.userPermissions <- map["user_permissions"]
    }
    
    func getUserModel() -> UserModel {
        let userModel = UserModel()
        userModel.company = self.company
        userModel.email = self.email
        userModel.firstName = self.firstName
        userModel.id = self.id
        userModel.lastName = self.lastName
        
        return userModel
    }
}
