//
//  ResponseUserVerifyTokenModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/5/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import ObjectMapper

enum ResponseUserVerifyTokenModelState {
    case initialState
    case isValid
    case isInvalid
}

class ResponseUserVerifyTokenModel: Mappable {
    
    var internalCode: String?
    var valid: Bool?
    
    var responseState: ResponseUserVerifyTokenModelState = .initialState
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
        self.internalCode <- map["internal_code"]
        self.valid <- map["valid"]
        self.updateResponseState()
    }
    
    func updateResponseState() {
        
        if let internalCode = self.internalCode {
            
            switch internalCode {
            case "HHIC-900":
                self.responseState = .isValid
                break
            default:
                self.responseState = .isInvalid
                break
            }
        } else {
            
            self.responseState = .isInvalid
        }
    }
}
