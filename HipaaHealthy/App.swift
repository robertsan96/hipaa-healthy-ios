//
//  App.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation

class App {
    
    static let shared: App = App()
    let routingCoordinator: RoutingCoordinator
    
    private init() {
        self.routingCoordinator = RoutingCoordinator()
    }
}
