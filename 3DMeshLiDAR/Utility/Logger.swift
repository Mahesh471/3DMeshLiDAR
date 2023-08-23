//
//  Logger.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 22/08/23.
//

import Foundation
import os

public func getLogger(category: String = "") -> Logger {
    let logger = Logger(subsystem: "3DMeshLiDAR",
                        category: category)
    return logger
}
