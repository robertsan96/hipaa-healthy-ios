//
//  NetService.swift
//  HipaaHealthy
//
//  Created by Robert Sandru on 1/31/17.
//  Copyright © 2017 HipaaHealthy. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

class NetService {
    
    var request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    func sendRequest<T: Mappable>(type: T.Type) -> Observable<T?> {
        return Observable.create { o in
            let request = Alamofire.request(self.request.route.url!,
                                            method: self.request.route.httpMethod,
                                            parameters: self.request.parameters,
                                            encoding: self.request.encoding,
                                            headers: self.request.headers)
                .responseObject(completionHandler: { (data: DataResponse<T>) in
                    let response = data.result.value
                    o.onNext(response)
                    o.onCompleted()
                })
            return Disposables.create {
                request.cancel()
                print("did dispose sendRequest")
            }
        }
    }
}
