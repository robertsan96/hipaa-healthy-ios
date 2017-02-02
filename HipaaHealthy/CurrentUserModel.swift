//
//  CurrentUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation

class CurrentUser {
    
    static let shared: CurrentUser = CurrentUser()
    
    var user: UserModel?
    var token: String?
    
    init() { }
    
    func updateUserData() {
        
    }
    
    func updateToken(withToken token: String) {
        self.token = token
    }
}
