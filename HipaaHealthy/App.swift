//
//  App.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit
import RxSwift

class App {

    static let shared: App = App()

    let routingCoordinator: RoutingCoordinator
    var rootViewController: UIViewController?
    var currentUserModel: CurrentUserModel

    var mainTimer: TimeInterval = 5.0
    
    var disposeBag = DisposeBag()
    var mainTimerDisposeBag = DisposeBag()

    private init() {
        self.routingCoordinator = RoutingCoordinator()
        self.currentUserModel = CurrentUserModel.shared
        self.currentUserModel.delegate = self
        
        Observable<Int>
            .interval(self.mainTimer, scheduler: MainScheduler.instance)
            .subscribe(onNext: timerOperations)
            .addDisposableTo(mainTimerDisposeBag)
    }

    func startApp() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let initialViewController = Storyboard.Authentication.loginViewController()
        initialViewController.delegate = self
        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate?.window?.rootViewController = initialViewController
        appDelegate?.window?.makeKeyAndVisible()
        
        self.rootViewController = appDelegate?
            .window?.rootViewController
    }

    func timerOperations(repeatCount: Int) {
        self.currentUserModel.updateAuthStatusByToken()
    }
    
    func showHome() {
        let vc = Storyboard.Home.homeViewController()
        self.rootViewController?.show(vc, sender: nil)
    }
    
    func showLogin() {
        
        let vc = Storyboard.Authentication.loginViewController()
        vc.delegate = self
        
        self.rootViewController?.show(vc, sender: nil)
    }
}

extension App: LoginViewControllerDelegate {
    
    func loginViewControllerDidLogin(viewController: LoginViewController) {
       showHome()
        
    }
    
    func loginViewControllerDidFailLogin(viewController: LoginViewController) { }
}

extension App: CurrentUserModelDelegate {
    
    func currentUserModelDelegateLoggedIn(model: CurrentUserModel) { }
    
    func currentUserModelDelegateLoggedOut(model: CurrentUserModel) {
        print("logged out")
        showLogin()
    }
}
