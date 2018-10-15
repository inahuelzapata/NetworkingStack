//
//  Endpoint.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }

    var path: String { get }

    func buildURL() -> String
}
