//
//  LoginViewController.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var authBoxView: UIView!
    @IBOutlet weak var emailTextField: HHTextFieldLogin!
    @IBOutlet weak var passwordTextField: HHTextFieldLogin!
    @IBOutlet weak var lostPasswordButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let params: Parameters = [
//            "email": "codecontrive@gmail.com",
//            "password": "userx2"
//        ]
//        let _ = AuthenticationService().login(params: params).subscribe(onNext: { result in
//            print("THE LOGIN WAS A SUCCESS: \(result)")
//            print("WELCOME \(CurrentUser.shared.user?.firstName)")
//
//        })
        
        
        self.passwordTextField.isSecureTextEntry = true
        self.emailTextField.layer.frame.size.width = 10
        
        self.lostPasswordButton.contentHorizontalAlignment = .right
        
        let user = AuthenticationService().getUser(usingToken: "8ac1f93896bf0f7a3806320311a1b4d7e7945595")
            .subscribe(onNext: { user in
                if let user = user {
                    print("Hello \(user.firstName)")
                } else {
                    print("Pleaca acas ca nu e bun tokenu")
                }
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gestureCloseKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}

