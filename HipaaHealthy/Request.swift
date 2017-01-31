//
//  Request.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    var route: Route
    var parameters: Parameters?
    var encoding: ParameterEncoding
    var headers: HTTPHeaders?
    
    init(route: Route, encoding: ParameterEncoding) {
        self.route = route
        self.encoding = encoding
    }
    
    init(route: Route, encoding: ParameterEncoding, parameters: Parameters?, headers: HTTPHeaders?) {
        self.route = route
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
    }
}
