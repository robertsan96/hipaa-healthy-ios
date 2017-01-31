//
//  RoutingCoordinator.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation

class RoutingCoordinator {
    
    let apiURL: String = "https://api.hipaahealthy.com/api/"
    let apiVersion: String = "1.0"
    var baseURL: URL?
    
    init() {
        
        self.baseURL = buildBaseURL()
    }
    
    func buildBaseURL() -> URL? {
        
        var builtURLString: String
        builtURLString = self.apiURL + self.apiVersion + "/"
        
        return URL(string: builtURLString)
    }

}
