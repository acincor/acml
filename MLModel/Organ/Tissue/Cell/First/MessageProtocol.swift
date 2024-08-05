//
//  MessageProtocol.swift
//  MLModel
//
//  Created by Monkey hammer on 8/4/24.
//

protocol MessageProtocol: CustomStringConvertible, Equatable {
    var expiresDate: Date? { get set }
    var geT: (() -> (Date?)) { get set }
    var complete: ((Date?) -> ()) { get set }
    var percent: Double? { get set }
}
