//
//  Data+Extension.swift
//  NetworkingStack
//
//  Created by Nahuel Zapata on 10/15/18.
//  Copyright © 2018 Publishers Clearing House. All rights reserved.
//

import Foundation

extension Data {
    func toJson() -> NSString {
        guard let jsonString = NSString(data: self, encoding: String.Encoding.utf8.rawValue) else {
            NSLog("Can't create string with data.")
            return "{}"
        }

        return jsonString
    }
}
