//
//  ResponseUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseUserModel: Mappable {
    
    var internalCode: String?
    var results: ResponseResultsUserModel?
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.internalCode <- map["internal_code"]
        self.results <- map["results"]
    }
    

}
