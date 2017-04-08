//
//  ContainerViewController.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/8/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit

enum ContainerViewSlideOutState {
    
    case leftPanelCollapsed
    case leftPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    var currentSlideOutState: ContainerViewSlideOutState = .leftPanelCollapsed {
        didSet {
            let shouldShowShadow = (self.currentSlideOutState != .leftPanelCollapsed)
            showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)
        }
    }
    var leftPanelViewController: LeftPanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centerViewController = Storyboard.Layout.centerViewController()
        self.centerViewController.delegate = self
        
        self.centerNavigationController = UINavigationController(rootViewController: centerViewController)
        self.centerNavigationController.isNavigationBarHidden = true
        self.view.addSubview(self.centerNavigationController.view)
        self.addChildViewController(self.centerNavigationController)
        
        self.centerNavigationController.didMove(toParentViewController: self)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.centerNavigationController.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        if self.currentSlideOutState == .leftPanelExpanded {
            toggleLeftPanel()
        }
    }
}

extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (self.currentSlideOutState != .leftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        
        if self.leftPanelViewController == nil {
            self.leftPanelViewController = Storyboard.Layout.leftPanelViewController()
            
            addChildLeftPanelViewController(leftPanelViewController: self.leftPanelViewController!)
        }
    }
    
    func addChildLeftPanelViewController(leftPanelViewController: LeftPanelViewController) {
        
        self.view.insertSubview(leftPanelViewController.view, at: 0)
        self.addChildViewController(leftPanelViewController)
        leftPanelViewController.didMove(toParentViewController: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        
        if shouldExpand {
            self.currentSlideOutState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: self.centerNavigationController.view.frame.width - self.centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0, completion: { _ in
                self.currentSlideOutState = .leftPanelCollapsed
                
                self.leftPanelViewController!.view.removeFromSuperview()
                self.leftPanelViewController = nil
            })
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if shouldShowShadow {
            self.centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            self.centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}
