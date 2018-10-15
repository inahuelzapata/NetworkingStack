//
//  JSONDecoder+Extension.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type,
                              withJSONObject object: Any,
                              options opt: JSONSerialization.WritingOptions = .prettyPrinted) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        print(data.toJson())
        return try decode(T.self, from: data)
    }
}
