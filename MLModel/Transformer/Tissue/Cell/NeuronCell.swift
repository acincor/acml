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
        msg = coder.decodeObject(forKey: "msg") as! [Any]
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
            NSLog("begin receiving, please be waiting...")
            dendrite.receive()
            NSLog("dendrite ended receiving..., messages \(dendrite.deploy?.message ?? []), count \(dendrite.deploy?.message.count ?? 0), please be waiting...")
            guard let message = dendrite.deploy?.message else {
                continue
            }
            NSLog("begin receiving, please be waiting...")
            dendrite.deploy?.message = []
            NSLog("This array was began setting to empty array...")
            if message.isEmpty {
                continue
            }
            NSLog("This array was began uploading items for getting a array that items were messages...")
            self.msg = message + msg
            NSLog("This message was received.")
        }
        for nerveEnding in self.nerveEndings {
            nerveEnding.deploy?.message = self.msg
            NSLog("begin sending, messages \(nerveEnding.deploy?.message ?? []), count \(nerveEnding.deploy?.message.count ?? 0), please be waiting...")
            nerveEnding.send()
            NSLog("This message was sent.")
        }
    }
    public static func == (lhs: NeuronCell, rhs: NeuronCell) -> Bool {
        return lhs.dendrites == rhs.dendrites && lhs.cellBody == rhs.cellBody && lhs.nerveEndings == rhs.nerveEndings
    }
    public init(cellBody: CellBodyModel, dendrites: [DendriteModel], nerveEndings: [NerveEndingModel], msg: [Any]) {
        self.cellBody = cellBody
        self.msg.append(contentsOf: msg)
        self.dendrites = dendrites
        self.nerveEndings = nerveEndings
    }
}
