//
//  UIImageView.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/3/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func rotateView(duration: Double = 1) {
        let kRotationAnimationKey = "com.myapplication.rotationanimationkey" // Any key
        if self.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(M_PI * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            self.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
}
