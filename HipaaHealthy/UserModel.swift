//
//  UserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation

class UserModel {
    
    var id: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    var company: Int?
    var userPermissions: [UserPermissionModel]?
    
    init() { }
    
}
