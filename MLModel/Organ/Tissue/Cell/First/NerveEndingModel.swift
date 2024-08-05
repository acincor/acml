//
//  NerveEndingModel.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class NerveEndingModel: MessageProtocol {
    var message = String()
    public var dendrite: DendriteModel?
    var expiresDate: Date?
    var geT: (() -> (Date?))
    var complete: ((Date?) -> ())
    public init(dendrite: DendriteModel? = nil, percent : Double? = nil, get: @escaping (() -> (Date?)), complete: @escaping ((Date?) -> ())) throws {
        self.dendrite = dendrite
        self.percent = percent
        self.geT = get
        self.complete = complete
        set()
    }
    func set() {
        expiresDate = Date.now.addingTimeInterval(300*(percent ?? 0))
        complete(expiresDate)
    }
    public static func == (lhs: NerveEndingModel, rhs: NerveEndingModel) -> Bool {
        return lhs.message == rhs.message && lhs.dendrite == rhs.dendrite && lhs.expiresDate == rhs.expiresDate && lhs.percent == rhs.percent
    }
    func send() {
        if((geT() ?? Date()).timeIntervalSince1970 < Date().timeIntervalSince1970) {
            self.dendrite = nil
            self.percent = 0
            return
        }
        set()
        self.message += dendrite?.message ?? ""
        //NSLog("sent messages %@", message)
    }
    var percent: Double?{
        didSet {
            set()
        }
    }
    public var description: String {
        "<FIRST NERVEENDING \(self.expiresDate?.description ?? "null")>"
    }
}
