//
//  DebugUtils.swift
//  TestCase
//
//  Created by Rafli on 22/05/23.
//

import Foundation

class DebugUtils {
    static func printDebug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        print("[Debug] \(fileName) - \(function) - Line \(line): \(message)")
        #endif
    }
}
