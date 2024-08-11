//
//  NeuronCell.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//
public class NeuronCell: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder) {
        coder.encode(msg, forKey: "msg")
        coder.encode(nerveEndings, forKey: "nerveEndings")
        coder.encode(dendrites, forKey: "dendrites")
        coder.encode(cellBody, forKey: "cellBody")
    }
    public required init?(coder: NSCoder) {
        msg = coder.decodeObject(forKey: "msg") as? [Any] ?? []
        nerveEndings = coder.decodeObject(forKey: "nerveEndings") as? [NerveEndingModel] ?? []
        dendrites = coder.decodeObject(forKey: "dendrites") as? [DendriteModel] ?? []
        cellBody = coder.decodeObject(forKey: "cellBody") as! CellBodyModel
        super.init()
    }
    public override var description: String{
        "<CELL NEURONCELL \(msg) \(cellBody) \(dendrites) \(nerveEndings)>"
    }
    var cellBody: CellBodyModel
    var msg = [Any]()
    public var dendrites: [DendriteModel]
    public var nerveEndings: [NerveEndingModel]
    public func build() {
        for dendrite in self.dendrites {
            dendrite.receive()
            var i = 0
            for item in dendrite.deploy?.message ?? [] {
                self.msg.insert(item, at: i)
                i += 1
            }
        }
        for nerveEnding in self.nerveEndings {
            nerveEnding.deploy?.message = self.msg
            nerveEnding.send()
        }
    }
    public static func == (lhs: NeuronCell, rhs: NeuronCell) -> Bool {
        return lhs.dendrites == rhs.dendrites && lhs.cellBody == rhs.cellBody && lhs.nerveEndings == rhs.nerveEndings
    }
    public init(cellBody: CellBodyModel, dendrites: [DendriteModel], nerveEndings: [NerveEndingModel], msg: [Any]) {
        self.cellBody = cellBody
        for item in msg {
            self.msg.append(item)
        }
        self.dendrites = dendrites
        self.nerveEndings = nerveEndings
    }
}
