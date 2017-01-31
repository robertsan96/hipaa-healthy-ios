//
//  NetService.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetService {
    
    var request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    func sendRequest() {
        Alamofire.request(self.request.route.url!,
                          method: self.request.route.httpMethod,
                          parameters: self.request.parameters,
                          encoding: self.request.encoding,
                          headers: self.request.headers)
            .responseObject(completionHandler: { (data: DataResponse<UserModel>) -> Void in
                
            })
    }
    
}
