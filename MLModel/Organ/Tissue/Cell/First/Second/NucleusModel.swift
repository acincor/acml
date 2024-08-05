//
//  NucleusModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

class NucleusModel: CustomStringConvertible, Hashable {
    var dnas = [DNAModel]()
    init(dnas: [DNAModel]) throws {
        if(hasDuplicates(array: dnas)) {
            throw NSError(domain: "com.ACInc.Boke", code: -1011, userInfo: ["error": "the array has duplicates"])
        }
        self.dnas = dnas
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(dnas)
    }
    static func == (lhs: NucleusModel, rhs: NucleusModel) -> Bool {
        return lhs.dnas == rhs.dnas
    }
    var description: String {
        "<SECOND NUCLEUS \(dnas)>"
    }
}
