//
//  Route.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire

class Route {
    var slug: String
    var httpMethod: HTTPMethod
    var url: URL?
    
    init(slug: String, httpMethod: HTTPMethod) {
        
        self.slug = slug
        self.httpMethod = httpMethod
        self.url = self.buildURL()
    }
    
    private func buildURL() -> URL? {
    
        if let baseURL = App.shared.routingCoordinator.baseURL {
            
            var builtURLString: String
            builtURLString = baseURL.absoluteString + self.slug
            
            return URL(string: builtURLString)
        } else {
            
            return nil
        }
        
    }
    
}
