//
//  DNAModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//
public class DNAModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    @objc var rnaId: [Int]
    public func encode(with coder: NSCoder) {
        coder.encode(rnaId, forKey: "rnaId")
    }
    public required init?(coder: NSCoder) {
        rnaId = coder.decodeObject(forKey: "rnaId") as! [Int]
    }
    public init(rnaId: [Int]) throws{
        if hasDuplicates(array: rnaId) {
            throw NSError(domain: "com.ACInc.MLModel", code: -1011, userInfo: ["error": "the array has duplicates"])
        }
        self.rnaId = rnaId
    }
    public override var description: String {
        "<THIRD DNA \(self.rnaId)>"
    }
    public static func == (lhs: DNAModel, rhs: DNAModel) -> Bool {
        return lhs.rnaId == rhs.rnaId
    }
}
