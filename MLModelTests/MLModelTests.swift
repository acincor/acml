//
//  MLModelTests.swift
//  MLModelTests
//
//  Created by Monkey hammer on 7/31/24.
//

import Testing
@testable import MLModel
class expires {
    static let shared = expires()
    var expiresDates = [Date]()
    func example() async throws {
        /* don't build
        let brain = try rand(2, 3, 3, true, false)
        let msgs = brain.msgs
        NSLog("built-in msg \(msgs)")
         */
        let brain = try rand(2, 1, 3, 3, true, true)
        let msgs = brain.msgs
        print("the structures of brain \n\(brain)")
        print("non-built-in added msg \n\(msgs)")
    }
}
struct MLModelTests {
    @Test mutating func example() async throws {
        try await expires.shared.example()
    }
}
