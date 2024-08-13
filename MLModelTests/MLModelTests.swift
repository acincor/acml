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
        let brain = try rand(2, 3, 2, 3, 9, true)
        NSLog("built-in msg \n\(brain.msgs.last?.last?.description ?? NSNull().description)")
        brain.build { msgs in
            NSLog("the structures of brain \n\(brain.description)")
            NSLog("non-built-in added msg \n\(msgs.last?.last?.description ?? NSNull().description)")
        }
    }
}
struct MLModelTests {
    @Test mutating func example() async throws {
        try await expires.shared.example()
    }
}
