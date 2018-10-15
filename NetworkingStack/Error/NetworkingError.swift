//
//  NetworkingError.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case unknown
    case parsing
    case invalidJSONParsing
    case apiError(body: [String: Any])
    case parseable(Encodable)
    case discardable(statusCode: Int)
}
