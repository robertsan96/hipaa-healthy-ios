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
    
    func login(params: [String: Any]) -> Observable<Bool> {
        return Observable.create { o in
            let route = Routes.Authentication.postLogin
            let headers: HTTPHeaders = [
                "Content-Type": "Application/json"
            ]
            let request = Request(route: route, encoding: JSONEncoding.default, parameters: params, headers: headers)
            let netService = NetService(request: request)
            
            let sendRequest = netService.sendRequest(type: ResponseUserLoginModel.self).subscribe(onNext: { response in
                if response?.responseState == .didFail {
                    o.onNext(false)
                    o.onCompleted()
                }
                if let token = response?.token {
                    CurrentUser.shared.updateToken(withToken: token)
                    let _ = self.getUser(usingToken: token).subscribe(onNext: { response in
                        CurrentUser.shared.user = response
                        o.onNext(true)
                        o.onCompleted()
                    })
                } else {
                    o.onNext(false)
                    o.onCompleted()
                }
            })
            return Disposables.create {
                sendRequest.dispose()
                print("did dispose login")
            }
        }
    }
    
    func getUser(usingToken token: String) -> Observable<UserModel?> {
        return Observable.create { o in
            let route = Routes.Authentication.getUser
            let headers: HTTPHeaders = [
                "Content-Type": "Application/json",
                "Authorization": "Token \(token)"
            ]
            let request = Request(route: route, encoding: JSONEncoding.default, parameters: nil, headers: headers)
            let netService = NetService(request: request)
            
            let sendRequest = netService.sendRequest(type: ResponseUserModel.self).subscribe(onNext: { response in
                if let response = response {
                    switch response.responseState {
                    case .didGetUser:
                        o.onNext(response.results?.getUserModel())
                        o.onCompleted()
                        break
                    default:
                        o.onNext(nil)
                        o.onCompleted()
                        break
                    }
                } else {
                    o.onNext(nil)
                    o.onCompleted()
                }
            })
            return Disposables.create {
                sendRequest.dispose()
                print("did dispose getUser")
            }
        }
    }
}




















