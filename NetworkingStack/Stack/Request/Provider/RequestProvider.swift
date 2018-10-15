//
//  RequestProvider.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation
import PromiseKit

public protocol RequestProvider {
    init(command: RequestCommandable)

    func execute<Output: HTTPResponse, Model: Decodable>(request: HTTPRequestable, expectedModel: Model.Type)
    throws -> Output
}

public struct PromiseRequestProvider: RequestProvider {
    let requestCommand: RequestCommandable

    public init(command: RequestCommandable) {
        self.requestCommand = command
    }

    public func execute<Output: HTTPResponse, Model: Decodable>(request: HTTPRequestable, expectedModel: Model.Type)
    throws -> Output {
        guard let promise = requestCommand.execute(request: request, with: Model.self) as? Output else {
            throw NetworkingError.parsing
        }

        return promise
    }
}

