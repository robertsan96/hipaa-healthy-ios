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
        let vc = Storyboard.Home.homeViewController()
        self.rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func timerOperations(repeatCount: Int) {
        self.currentUserModel.verifyToken()
    }
}

extension App: CurrentUserModelDelegate {
    func currentUserModelDelegateLoggedIn(model: CurrentUserModel) {
        print("LOGGED IN ... HERES A DELEGATE")
    }
    
    func currentUserModelDelegateLoggedOut(model: CurrentUserModel) {
        print("YOU ARE LOGGED OUT HONEY")
    }
    
    func currentUserModelDelegateLoggedOutDueToInvalidToken(model: CurrentUserModel) {
        print("LOGGED OUT FALSE TOKEN")
    }
}
