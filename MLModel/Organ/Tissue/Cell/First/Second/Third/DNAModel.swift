//
//  DNAModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//
public class DNAModel: CustomStringConvertible, Hashable {
    var rnas: [RNAModel]
    public init(rnas: [RNAModel]) throws {
        if(hasDuplicates(array: rnas)) {
            throw NSError(domain: "com.ACInc.Boke", code: -1011, userInfo: ["error": "the array has duplicates"])
        }
        self.rnas = rnas
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rnas)
    }
    public var description: String {
        "<THIRD DNA \(self.rnas)>"
    }
    public static func == (lhs: DNAModel, rhs: DNAModel) -> Bool {
        return lhs.rnas == rhs.rnas
    }
}
