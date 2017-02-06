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

enum LoginViewControllerState {
    
    case idle
    case loggingIn
}

protocol LoginViewControllerDelegate: class {
    
    func loginViewControllerDidLogin(viewController: LoginViewController)
    func loginViewControllerDidFailLogin(viewController: LoginViewController)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var authBoxView: UIView!
    @IBOutlet weak var emailTextField: HHTextFieldLogin!
    @IBOutlet weak var passwordTextField: HHTextFieldLogin!
    @IBOutlet weak var lostPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinner: UIImageView!
    
    var disposeBag: DisposeBag = DisposeBag()
    let viewModel: LoginViewModel = LoginViewModel()
    var controllerState: Variable<LoginViewControllerState> = Variable(.idle)
    
    weak var delegate: LoginViewControllerDelegate?
    
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
    
//        let _ = AuthenticationService().verifyToken(token: "8ac1f93896bf0f7a3806320311a1b4d7e7945595")
//            .subscribe(onNext: { valid in
//                print("DECI TOKENUL E \(valid)")
//            })

        self.controllerState.asObservable().subscribe(onNext: updatedControllerState).addDisposableTo(disposeBag)
        
        self.passwordTextField.isSecureTextEntry = true
        self.emailTextField.layer.frame.size.width = 10
        
        self.lostPasswordButton.contentHorizontalAlignment = .right
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gestureCloseKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        self.changeLoginButtonState(enabled: false)
        self.controllerState.value = .loggingIn
        
        if let email = email, let password = password {
            viewModel.sendLogin(email: email, password: password).asObservable().subscribe(onNext: { [weak self] success in
                self?.changeLoginButtonState(enabled: true)
                self?.controllerState.value = .idle
                if success {
                    self?.delegate?.loginViewControllerDidLogin(viewController: self!)
                } else {
                    self?.delegate?.loginViewControllerDidFailLogin(viewController: self!)
                    self?.showLoginFailedAlert()
                }
            }).addDisposableTo(disposeBag)
        }
    }
    
    func changeLoginButtonState(enabled: Bool) {
        self.loginButton.isUserInteractionEnabled = enabled
    }
    
    func updateAuthBoxVisibility(visible: Bool) {
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            if visible {
                self?.authBoxView.alpha = 1.0
            } else {
                self?.authBoxView.alpha = 0.0
            }
        })
    }
    
    func updateSpinnerVisibility(visible: Bool) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            if visible {
                self?.spinner.alpha = 1.0
            } else {
                self?.spinner.alpha = 0.0
            }
        })
    }
    
    func updatedControllerState(state: LoginViewControllerState) {
        switch state {
        case .idle:
            self.updateAuthBoxVisibility(visible: true)
            self.updateSpinnerVisibility(visible: false)
            self.spinner.rotateView()
            break
        case .loggingIn:
            self.updateAuthBoxVisibility(visible: false)
            self.updateSpinnerVisibility(visible: true)
            break
        }
    }
    
    func showLoginFailedAlert() {
        let alertTitle = "Authentication failed"
        let alertMessage = "Please try again. If you forgot your password, continue by tapping on Lost Password button."
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertActionCancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alertController.addAction(alertActionCancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
