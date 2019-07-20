//
//  SwiftyBeaver+Extension.swift
//  RxSwiftRealmExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 6/19/19.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import SwiftyBeaver

extension SwiftyBeaver {
    /// log something which help during debugging (low priority)
    /// use log when start function
    open class func enter(_ message: @autoclosure () -> Any = "",
                          _ file: String = #file,
                          _ function: String = #function,
                          line: Int = #line,
                          context: Any? = nil) {
        let messageText: String = message() as? String ?? ""
        debug("IN\(messageText.isEmpty ? "" : " - \(messageText)")", file, function, line: line, context: context)
    }

    /// log something which help during debugging (low priority)
    /// use log when exit function
    open class func exit(_ message: @autoclosure () -> Any = "",
                         _ file: String = #file,
                         _ function: String = #function,
                         line: Int = #line,
                         context: Any? = nil) {
        let messageText: String = message() as? String ?? ""
        debug("OUT\(messageText.isEmpty ? "" : " - \(messageText)")", file, function, line: line, context: context)
    }
}
