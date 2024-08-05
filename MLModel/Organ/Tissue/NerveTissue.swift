//
//  NerveTissue.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class NerveTissue: CustomStringConvertible {
    var neuronCells: [NeuronCell]
    public init(neuronCells: [NeuronCell]) {
        self.neuronCells = neuronCells
    }
    public func build() {
        for neuronCell in neuronCells {
            neuronCell.build()
        }
    }
    var msgs: [String] {
        var messages = [String]()
        for neuronCell in neuronCells {
            messages.append(neuronCell.msg)
        }
        return messages
    }
    public var description: String {
        "<TISSUE NERVETISSUE \(msgs) \(neuronCells)>"
    }
}
