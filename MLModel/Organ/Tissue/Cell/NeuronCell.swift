//
//  NeuronCell.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//
public class NeuronCell: CustomStringConvertible, Equatable {
    public var description: String{
        "<CELL NEURONCELL \(msg) \(cellBody) \(dendrites) \(nerveEndings)>"
    }
    var cellBody: CellBodyModel
    var msg = String()
    var dendrites: [DendriteModel]
    var nerveEndings: [NerveEndingModel]
    func build() {
        for dendrite in dendrites {
            dendrite.receive()
            self.msg = dendrite.message + self.msg
        }
        for nerveEnding in nerveEndings {
            nerveEnding.message = msg
            nerveEnding.send()
        }
    }
    public static func == (lhs: NeuronCell, rhs: NeuronCell) -> Bool {
        return lhs.dendrites == rhs.dendrites && lhs.cellBody == rhs.cellBody && lhs.nerveEndings == rhs.nerveEndings && lhs.msg == rhs.msg
    }
    public init(cellBody: CellBodyModel, dendrites: [DendriteModel], nerveEndings: [NerveEndingModel], msg: String) {
        self.cellBody = cellBody
        self.msg = msg
        self.dendrites = dendrites
        self.nerveEndings = nerveEndings
    }
}
