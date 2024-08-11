//
//  CellBodyModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

public class CellBodyModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder) {
        coder.encode(nucleus, forKey: "nucleus")
    }
    public required init?(coder: NSCoder) {
        nucleus = coder.decodeObject(forKey: "nucleus") as! NucleusModel
    }
    @objc var nucleus: NucleusModel
    public init(nucleus: NucleusModel){
        self.nucleus = nucleus
    }
    public static func == (lhs: CellBodyModel, rhs: CellBodyModel) -> Bool {
        return lhs.nucleus == rhs.nucleus
    }
    public override var description: String {
        "<FIRST CELLBODY \(nucleus)>"
    }
}
