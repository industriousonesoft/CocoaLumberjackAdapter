//
//  APRLogger.swift
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//

import Foundation
import APROCLogger

public
enum APRLogger {
    public
    static func warning(_ msg: String) {
        APROCLogger.warning(msg)
    }
    public
    static func info(_ msg: String) {
        APROCLogger.info(msg)
    }
    public
    static func error(_ msg: String) {
        APROCLogger.error(msg)
    }
    public
    static func debug(_ msg: String) {
        APROCLogger.debug(msg)
    }
    public
    static func verbose(_ msg: String) {
        APROCLogger.verbose(msg)
    }
}
