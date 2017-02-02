//
//  ResponseUserLoginModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseUserLoginModel: Mappable {
    
    var internalCode: String?
    var token: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
        self.internalCode <- map["internal_code"]
        self.token <- map["token"]
    }
    
}
