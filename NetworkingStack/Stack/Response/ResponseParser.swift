//
//  ResponseParser.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

public protocol HTTPResponse { }

extension Promise: HTTPResponse { }

public protocol JsonResponse { }

extension DataResponse: JsonResponse { }

public protocol ResponseParser {

    init(decoder: JSONDecoder)

    func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type,
                                      decodingStrategy: JSONDecoder.KeyDecodingStrategy) throws -> T
}

public class AlamofireResponseParser: ResponseParser {
    let decoder: JSONDecoder

    public required init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    public func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type,
                                             decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        setKeyDecodingStrategy(decodingStrategy)
        guard let responseData = response as? DataResponse<Any> else {
            throw NetworkingError.unknown
        }

        switch responseData.result {
        case .success(let value):
            do {
                let decodedValue = try decoder.decode(T.self, withJSONObject: value)
                return decodedValue
            } catch {
                print(error)
                throw NetworkingError.invalidJSONParsing
            }
        case .failure:
            guard let data = responseData.data else {
                throw NetworkingError.invalidJSONParsing
            }

            guard let errorData = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                throw NetworkingError.parsing
            }

            throw NetworkingError.apiError(body: errorData)
        }
    }

    func setKeyDecodingStrategy(_ strategy: JSONDecoder.KeyDecodingStrategy) {
        self.decoder.keyDecodingStrategy = strategy
    }
}
