//
//  ViewController.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let route = Routes.Authentication.getUser
//        let params: [String: Any] = [
//                "item": 121,
//                "answer": "Testam answerul"
//        ]
        let request = Request(route: route, encoding: JSONEncoding.default, parameters: nil, headers: ["Content-Type": "Application/json", "Authorization": "Token 8ac1f93896bf0f7a3806320311a1b4d7e7945595"])
        let netService = NetService(request: request)
        netService.sendRequest(type: ResponseUserModel.self).asObservable().subscribe(onNext: { success in
            print(success?.results?.firstName)
        }).addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

