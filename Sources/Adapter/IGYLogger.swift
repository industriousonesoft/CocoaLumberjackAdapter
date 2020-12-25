//
//  APRLogger.swift
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//

import Foundation
import IGYOCLogger

public
enum IGYLogger {
    public
    static func warning(_ msg: String) {
        IGYOCLogger.warning(msg)
    }
    public
    static func info(_ msg: String) {
        IGYOCLogger.info(msg)
    }
    public
    static func error(_ msg: String) {
        IGYOCLogger.error(msg)
    }
    public
    static func debug(_ msg: String) {
        IGYOCLogger.debug(msg)
    }
    public
    static func verbose(_ msg: String) {
        IGYOCLogger.verbose(msg)
    }
}
