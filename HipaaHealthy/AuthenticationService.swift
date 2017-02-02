//
//  AuthenticationService.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 2/2/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AuthenticationService {
    
    init() { }
    
    func login() -> Observable<Bool> {
        
        return Observable.create { o in
            
            let route = Routes.Authentication.postLogin
            let params: [String: Any] = [
                "email": "codecontrive@gmail.com",
                "password": "userx2"
            ]
            let headers: [String: String] = [
                "Content-Type": "Application/json"
            ]
            let request = Request(route: route, encoding: JSONEncoding.default, parameters: params, headers: headers)
            let netService = NetService(request: request)
            let sendRequest = netService.sendRequest(type: ResponseUserLoginModel.self).subscribe(onNext: { result in
                
                guard let token = result?.token else {
                    o.onNext(false)
                    o.onCompleted()
                    return
                }
                
                CurrentUser.shared.updateToken(withToken: token)
                
                o.onNext(true)
            })

            return Disposables.create {
                sendRequest.dispose()
                print("did dispose login")
            }
        }
    }
    
    func getUserByToken(token: String) -> Observable<Bool> {
        
        return Observable.create { o in
            
            return Disposables.create {
                
            }
        }
    }
}
