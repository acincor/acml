//
//  NucleusModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//

public class NucleusModel: CustomStringConvertible, Hashable {
    var dnas = [DNAModel]()
    public init(dnas: [DNAModel]) throws {
        if(hasDuplicates(array: dnas)) {
            throw NSError(domain: "com.ACInc.Boke", code: -1011, userInfo: ["error": "the array has duplicates"])
        }
        self.dnas = dnas
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dnas)
    }
    public static func == (lhs: NucleusModel, rhs: NucleusModel) -> Bool {
        return lhs.dnas == rhs.dnas
    }
    public var description: String {
        "<SECOND NUCLEUS \(dnas)>"
    }
}
