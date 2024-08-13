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
    public func build(_ finished: @escaping (([[[Any]]]) -> ())) {
        DispatchQueue.main.async {
            for nerveTissue in self.nerveTissues {
                queue.addOperation(QueueTask(closure: {
                    nerveTissue.build()
                    return nerveTissue.msgs
                }))
            }
            queue.runTask(finished)
        }
    }
    public var msgs: [[[Any]]] {
        var messages = [[[Any]]]()
        for nerveTissue in self.nerveTissues {
            messages.append(nerveTissue.msgs)
        }
        return messages
    }
    public var description: String {
        "<ORGAN BRAIN \(msgs) \(nerveTissues)>"
    }
}
