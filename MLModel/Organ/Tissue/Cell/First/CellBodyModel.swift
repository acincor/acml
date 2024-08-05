//
//  CellBodyModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

public class CellBodyModel: CustomStringConvertible {
    var nucleus: NucleusModel
    public init(nucleus: NucleusModel) throws {
        self.nucleus = nucleus
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(nucleus)
    }
    public static func == (lhs: CellBodyModel, rhs: CellBodyModel) -> Bool {
        return lhs.nucleus == rhs.nucleus
    }
    public var description: String {
        "<FIRST CELLBODY \(nucleus)>"
    }
}
