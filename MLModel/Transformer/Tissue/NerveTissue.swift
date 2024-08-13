//
//  NerveTissue.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class NerveTissue: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(neuronCells, forKey: "neuronCells")
    }
    
    public required init?(coder: NSCoder) {
        neuronCells = coder.decodeObject(forKey: "neuronCells") as? [NeuronCell] ?? []
    }
    
    var neuronCells: [NeuronCell]
    public init(neuronCells: [NeuronCell]) {
        self.neuronCells = neuronCells
    }
    public func build() {
        for neuronCell in self.neuronCells {
            neuronCell.build()
        }
    }
    public var msgs: [[Any]] {
        var messages = [[Any]]()
        for neuronCell in self.neuronCells {
            messages.append(neuronCell.msg)
        }
        return messages
    }
    public override var description: String {
        "<TISSUE NERVETISSUE \(msgs) \(neuronCells)>"
    }
}
