//
//  CurrentUserModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import RxSwift

enum CurrentUserModelAuthStatus {
    case loggedIn
    case loggedOut
    case loggedOutDueToInvalidToken
}

protocol CurrentUserModelDelegate: class {
    
    func currentUserModelDelegateLoggedIn(model: CurrentUserModel)
    func currentUserModelDelegateLoggedOut(model: CurrentUserModel)
    func currentUserModelDelegateLoggedOutDueToInvalidToken(model: CurrentUserModel)
}

class CurrentUserModel {

    static let shared: CurrentUserModel = CurrentUserModel()
    weak var delegate: CurrentUserModelDelegate?
    
    var user: UserModel?
    var token: String?
    private var unprocessedToken: String? {
        get {
            return self.token
        }
        set {
            self.token = newValue
            verifyToken()
        }
    }
    var authStatus: Variable<CurrentUserModelAuthStatus> = Variable(.loggedOut)
    var verifyTokenDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
    init() {
        self.authStatus.asObservable().distinctUntilChanged().subscribe(onNext: { [weak self] status in
            switch status {
            case .loggedOutDueToInvalidToken:
                self?.delegate?.currentUserModelDelegateLoggedOutDueToInvalidToken(model: self!)
                break
            case .loggedIn:
                self?.delegate?.currentUserModelDelegateLoggedIn(model: self!)
                break
            case .loggedOut:
                self?.delegate?.currentUserModelDelegateLoggedOut(model: self!)
                break
            }
        }).addDisposableTo(disposeBag)
    }

    func updateUserData() {

    }

    func updateToken(withToken token: String) {
        self.unprocessedToken = token
    }

    @objc func verifyToken() {
        self.verifyTokenDisposeBag = DisposeBag()
        if let token = self.token {
            let authService = AuthenticationService()
            authService.verifyToken(token: token).subscribe(onNext: { [weak self] isValid in
                if isValid {
                    self?.authStatus.value = .loggedIn
                } else {
                    if self?.authStatus.value == .loggedIn {
                        self?.authStatus.value = .loggedOutDueToInvalidToken
                    } else {
                        self?.authStatus.value = .loggedOut
                    }
                }
            }).addDisposableTo(verifyTokenDisposeBag)
        } else {
            self.authStatus.value = .loggedOut
        }
    }
}
