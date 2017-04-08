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
    
    struct Layout {
        
        static func centerViewController() -> CenterViewController {
            let storyboardName = "Main"
            let viewControllerId = "centerViewController"
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? CenterViewController {
                return vc
            } else {
                fatalError("Unable to instantiate view controller \(viewControllerId) from \(storyboardName) storyboard.")
            }
        }
        
        static func leftPanelViewController() -> LeftPanelViewController {
            let storyboardName = "Main"
            let viewControllerId = "leftPanelViewController"
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? LeftPanelViewController {
                return vc
            } else {
                fatalError("Unable to instantiate view controller \(viewControllerId) from \(storyboardName) storyboard.")
            }
        }
    }
    
}
