//
//  Routes.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire

struct Routes {
    
    struct Authentication {
        
        static let getUser = Route(slug: "user/", httpMethod: .get)
        static let postLogin = Route(slug: "user/login/", httpMethod: .post)
    }
    
    struct Items {
        static let postAnswer = Route(slug: "answer/", httpMethod: .post)
    }
}
