//
//  Brain.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

public class Brain: CustomStringConvertible {
    var nerveTissues: [NerveTissue]
    public init(nerveTissues: [NerveTissue]) {
        self.nerveTissues = nerveTissues
    }
    public func build() {
        for nerveTissue in nerveTissues {
            nerveTissue.build()
        }
    }
    public var msgs: [Any] {
        var messages = [Any]()
        for nerveTissue in nerveTissues {
            messages.append(nerveTissue.msgs)
        }
        return messages
    }
    public var description: String {
        "<ORGAN BRAIN \(msgs) \(nerveTissues)>"
    }
}
