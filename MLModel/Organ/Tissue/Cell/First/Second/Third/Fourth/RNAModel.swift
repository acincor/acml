//
//  RNAModel.swift
//  MLModel
//
//  Created by Monkey hammer on 7/31/24.
//
func hasDuplicates<T: Hashable>(array: [T]) -> Bool {
    return Set(array).count != array.count
}
class RNAModel: CustomStringConvertible, Hashable {
    var id: Int
    init(id: Int) {
        self.id = id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var description: String {
        "<FOURTH RNA \(id)>"
    }
    static func == (lhs: RNAModel, rhs: RNAModel) -> Bool {
        return lhs.id == rhs.id
    }
}
