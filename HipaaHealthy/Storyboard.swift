//
//  Storyboard.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/4/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit

struct Storyboard {
    
    struct Authentication {

        static func loginViewController() -> LoginViewController {
            let storyboardName = "Main"
            let viewControllerId = "loginViewController"
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? LoginViewController {
                return vc
            } else {
                fatalError("Unable to instantiate view controller \(viewControllerId) from \(storyboardName) storyboard.")
            }
        }
    }
    
    struct Home {
        
        static func homeViewController() -> HomeViewController {
            let storyboardName = "Main"
            let viewControllerId = "homeViewController"
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? HomeViewController {
                return vc
            } else {
                fatalError("Unable to instantiate view controller \(viewControllerId) from \(storyboardName) storyboard.")
            }
        }
    }
    
}
