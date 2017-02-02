//
//  ResponseResultsUserPermissionUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseResultsUserPermissionUserModel: Mappable {
    
    var codeName: String?
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.codeName <- map["codename"]
        self.id <- map["id"]
        self.name <- map["name"]
    }
    
}
