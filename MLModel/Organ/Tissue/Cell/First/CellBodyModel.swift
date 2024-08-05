//
//  CellBodyModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

class CellBodyModel: CustomStringConvertible {
    var nucleus: NucleusModel
    init(nucleus: NucleusModel) throws {
        self.nucleus = nucleus
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(nucleus)
    }
    static func == (lhs: CellBodyModel, rhs: CellBodyModel) -> Bool {
        return lhs.nucleus == rhs.nucleus
    }
    var description: String {
        "<FIRST CELLBODY \(nucleus)>"
    }
}
