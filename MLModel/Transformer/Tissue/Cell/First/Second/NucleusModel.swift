//
//  NucleusModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//
public class NucleusModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder) {
        coder.encode(dnas, forKey: "dnas")
    }
    public required init?(coder: NSCoder) {
        dnas = coder.decodeObject(forKey: "dnas") as! [DNAModel]
    }
    @objc var dnas = [DNAModel]()
    public init(dnas: [DNAModel]) throws {
        if hasDuplicates(array: dnas) {
            throw NSError(domain: "com.ACInc.MLModel", code: -1011, userInfo: ["error": "the array has duplicates"])
        }
        self.dnas = dnas
    }
    public static func == (lhs: NucleusModel, rhs: NucleusModel) -> Bool {
        return lhs.dnas == rhs.dnas
    }
    public override var description: String {
        "<SECOND NUCLEUS \(dnas)>"
    }
}
