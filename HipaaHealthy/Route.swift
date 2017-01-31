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
    var slug: String?
    var httpMethod: HTTPMethod
    var url: URL?
    
    init(httpMethod: HTTPMethod) {
        
        self.httpMethod = httpMethod
        self.url = self.buildURL()
    }
    
    init(slug: String, httpMethod: HTTPMethod) {
        
        self.slug = slug
        self.httpMethod = httpMethod
        self.url = self.buildURL()
    }
    
    private func buildURL() -> URL? {
    
        if let baseURL = App.shared.routingCoordinator.baseURL {
            
            var builtURLString: String
            if let slug = self.slug {
                builtURLString = baseURL.absoluteString + slug
            } else {
                return baseURL
            }
            
            return URL(string: builtURLString)
        } else {
            
            return nil
        }
    }
    
}
