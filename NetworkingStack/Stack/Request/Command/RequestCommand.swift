//
//  RequestCommand.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

public protocol RequestCommandable {
    init(executor: RequestExecutor)

    func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse
}

public class RequestCommand: RequestCommandable {
    let executor: RequestExecutor

    public required init(executor: RequestExecutor) {
        self.executor = executor
    }

    public func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse {
        return executor.execute(request: request, with: expectedType)
    }
}
