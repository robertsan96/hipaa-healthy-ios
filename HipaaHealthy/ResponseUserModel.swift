//
//  ResponseUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

enum responseUserModelState {
    case initialState
    case didGetUser
    case didFail
}
class ResponseUserModel: Mappable {
    
    var internalCode: String?
    var results: ResponseResultsUserModel?
    
    var responseState: responseUserModelState = .initialState
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.internalCode <- map["internal_code"]
        self.results <- map["results"]
        self.updateResponseState()
    }
    
    func updateResponseState() {
        
        if let internalCode = self.internalCode {
            switch internalCode {
            case "HHIC-006":
                self.responseState = .didGetUser
                break
            default:
                self.responseState = .didFail
                break
            }
        } else {
            self.responseState = .didFail
        }
    }
    
    
}
