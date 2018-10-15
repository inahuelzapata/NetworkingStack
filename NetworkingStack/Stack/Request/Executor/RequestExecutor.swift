//
//  RequestExecutor.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

public protocol RequestExecutor {
    func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse
}

public class AlamofireRequestExecutor: RequestExecutor {
    let responseHandler: ResponseParser

    public init(responseHandler: ResponseParser) {
        self.responseHandler = responseHandler
    }

    public func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse {
        return Promise<T> { seal in
            Alamofire.request(request.endpoint.buildURL(),
                              method: request.method,
                              parameters: request.params,
                              encoding: request.encoding,
                              headers: request.headers)
                .validate()
                .responseJSON { response in
                    do {
                        let parsedResponse = try
                            self.responseHandler.handleResponse(response: response, expectedType: T.self,
                                                                decodingStrategy: request.keyDecodingStrategy)
                        seal.fulfill(parsedResponse)
                    } catch {
                        seal.reject(error)
                    }
            }
        }
    }
}
