//
//  JSONEncoder+Extension.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T,
                                        options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)

        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
