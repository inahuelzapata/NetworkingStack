//
//  HTTPRequest.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Alamofire
import Foundation

public protocol HTTPRequestable {
    var endpoint: Endpoint { get set }

    var params: [String: Any] { get set }

    var encoding: JSONEncoding { get set }

    var headers: [String: String] { get set }

    var method: HTTPMethod { get set }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get set }
}

public struct HTTPRequest: HTTPRequestable {
    public var endpoint: Endpoint

    public var method: HTTPMethod

    public var params: [String: Any]

    public var encoding: JSONEncoding

    public var headers: [String: String]

    public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy

    public init(endpoint: Endpoint,
                httpMethod: HTTPMethod,
                parameters: [String: Any],
                encoding: JSONEncoding = JSONEncoding.default,
                headers: [String: String],
                decodingStrategy: JSONDecoder.KeyDecodingStrategy) {
        self.endpoint = endpoint
        self.method = httpMethod
        self.params = parameters
        self.encoding = encoding
        self.headers = headers
        self.keyDecodingStrategy = decodingStrategy
    }
}
