//
//  HTTPRequestBuilder.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Alamofire
import Foundation

public protocol RequestBuildeable {
    func build() -> HTTPRequestable

    func consume(endpoint: Endpoint) -> RequestBuildeable

    func withMethod(_ httpMethod: HTTPMethod) -> RequestBuildeable

    func filterBy(params: [String: Any]) -> RequestBuildeable

    func withHeaders(_ headers: [String: String]) -> RequestBuildeable

    func withEncoding(_ encoding: JSONEncoding) -> RequestBuildeable

    func withDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) -> RequestBuildeable
}

public class RequestBuilder: RequestBuildeable {

    private var endpoint: Endpoint!

    private var method: HTTPMethod!

    private var params = [String: Any]()

    private var encoding = JSONEncoding()

    private var headers = [String: String]()

    private var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys

    public init() {
    }

    @discardableResult
    public func build() -> HTTPRequestable {
        return HTTPRequest(endpoint: endpoint,
                           httpMethod: method,
                           parameters: params,
                           encoding: encoding,
                           headers: headers,
                           decodingStrategy: keyDecodingStrategy)
    }

    @discardableResult
    public func consume(endpoint: Endpoint) -> RequestBuildeable {
        self.endpoint = endpoint

        return self
    }

    @discardableResult
    public func withMethod(_ httpMethod: HTTPMethod) -> RequestBuildeable {
        self.method = httpMethod

        return self
    }

    @discardableResult
    public func filterBy(params: [String: Any]) -> RequestBuildeable {
        self.params = params

        return self
    }

    @discardableResult
    public func withHeaders(_ headers: [String: String]) -> RequestBuildeable {
        self.headers = headers

        return self
    }

    @discardableResult
    public func withEncoding(_ encoding: JSONEncoding) -> RequestBuildeable {
        self.encoding = encoding

        return self
    }

    @discardableResult
    public func withDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) -> RequestBuildeable {
        self.keyDecodingStrategy = strategy

        return self
    }
}
