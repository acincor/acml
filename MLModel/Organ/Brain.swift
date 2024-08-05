//
//  Brain.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

class Brain: CustomStringConvertible {
    var nerveTissues: [NerveTissue]
    init(nerveTissues: [NerveTissue]) {
        self.nerveTissues = nerveTissues
    }
    func build() {
        for nerveTissue in nerveTissues {
            nerveTissue.build()
        }
    }
    var msgs: [[String]] {
        var messages = [[String]]()
        for nerveTissue in nerveTissues {
            messages.append(nerveTissue.msgs)
        }
        return messages
    }
    var description: String {
        "<ORGAN BRAIN \(msgs) \(nerveTissues)>"
    }
}
