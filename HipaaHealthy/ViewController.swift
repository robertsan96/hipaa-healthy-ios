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
        let _ = AuthenticationService().login().subscribe(onNext: { result in
            print(result)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

