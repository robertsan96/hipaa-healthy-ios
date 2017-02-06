//
//  ResponseUserLoginModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

enum ResponseUserLoginModelState {
    case initialState
    case didSetToken
    case didFail
}

class ResponseUserLoginModel: Mappable {
    
    var internalCode: String?
    var token: String?
    
    var responseState: ResponseUserLoginModelState = .initialState
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
        self.internalCode <- map["internal_code"]
        self.token <- map["token"]
        self.updateResponseState()
    }
    
    func updateResponseState() {
        
        if let internalCode = self.internalCode {
            
            switch internalCode {
            case "HHIC-009":
                self.responseState = .didSetToken
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
