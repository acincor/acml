//
//  RNAModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//
func hasDuplicates<T: Hashable>(array: [T]) -> Bool {
    return Set(array).count != array.count
}
public class RNAModel: CustomStringConvertible, Hashable {
    var id: Int
    public init(id: Int) {
        self.id = id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public var description: String {
        "<FOURTH RNA \(id)>"
    }
    public static func == (lhs: RNAModel, rhs: RNAModel) -> Bool {
        return lhs.id == rhs.id
    }
}
