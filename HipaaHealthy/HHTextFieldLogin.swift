//
//  HHTextFieldLogin.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/3/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit
import SwiftHEXColors

@IBDesignable
class HHTextFieldLogin: UITextField {
    
    override func draw(_ rect: CGRect) {
        layer.borderWidth = 0
        layer.cornerRadius = 0
        borderStyle = .line
        
        layer.backgroundColor = HHColorPalette.DarkTheme.TextField.BackgroundColor?.cgColor
        textColor = HHColorPalette.DarkTheme.TextField.TextColor
        updateLeftViewByRestorationId()
        updatePlaceholderByRestorationId()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateLeftViewByRestorationId() {
        
        if let restorationId = restorationIdentifier {
            
            let leftViewImage: UIImageView = UIImageView(frame: CGRect(x: 10, y: 7, width: 29, height: 29))
            
            switch restorationId {
            case "loginEmailTextField":
                leftViewImage.image = UIImage(named: "IconEmail")
                break
            case "loginPasswordTextField":
                leftViewImage.image = UIImage(named: "IconPassword")
                break
            default:
                break
            }
            
            let leftViewPadding: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            leftViewPadding.addSubview(leftViewImage)
            leftView = leftViewPadding
            leftViewMode = .always
        }
    }
    
    func updatePlaceholderByRestorationId() {
        
        if let restorationId = restorationIdentifier {
            
            switch restorationId {
            case "loginEmailTextField":
                attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: HHColorPalette.DarkTheme.TextField.TextColor!])
                break
            case "loginPasswordTextField":
                attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: HHColorPalette.DarkTheme.TextField.TextColor!])
                break
            default:
                break
            }
        }
    }
}

