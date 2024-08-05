//
//  NerveTissue.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

class NerveTissue: CustomStringConvertible {
    var neuronCells: [NeuronCell]
    init(neuronCells: [NeuronCell]) {
        self.neuronCells = neuronCells
    }
    func build() {
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
    var description: String {
        "<TISSUE NERVETISSUE \(msgs) \(neuronCells)>"
    }
}
