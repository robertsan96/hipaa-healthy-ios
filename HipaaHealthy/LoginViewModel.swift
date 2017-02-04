//
//  LoginViewModel.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/4/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class LoginViewModel {
    
    init() { }
    
    func sendLogin(email: String, password: String) -> Observable<Bool> {
        let observable: Observable<Bool> = Observable
            .create { o in
            
            let authenticationService = AuthenticationService()
            let login = authenticationService.login(params: ["email": email, "password": password]).subscribe(onNext: { result in
                o.onNext(result)
                o.onCompleted()
            })
            
            return Disposables.create {
                login.dispose()
            }
        }
        return observable
    }
    
}
