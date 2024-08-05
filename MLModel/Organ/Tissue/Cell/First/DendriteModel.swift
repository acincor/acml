//
//  DendriteModel.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class DendriteModel: MessageProtocol {
    public var nerveEnding: NerveEndingModel?
    var message = String()
    var expiresDate: Date?
    var geT: (() -> (Date?))
    var complete: ((Date?) -> ())
    public init(nerveEnding: NerveEndingModel? = nil, percent: Double? = nil, get: @escaping (() -> (Date?)), complete: @escaping ((Date?) -> ())) throws {
        self.nerveEnding = nerveEnding
        self.percent = percent
        self.geT = get
        self.complete = complete
        set()
    }
    func receive() {
        if(Date().timeIntervalSince1970 > (geT() ?? Date()).timeIntervalSince1970) {
            self.percent = 0
            self.nerveEnding = nil
            return
        }
        set()
        //NSLog("received messages %@", nerveEnding?.message ?? "nil")
        message = nerveEnding?.message ?? ""
    }
    public static func == (lhs: DendriteModel, rhs: DendriteModel) -> Bool {
        return lhs.nerveEnding == rhs.nerveEnding && lhs.expiresDate == rhs.expiresDate && lhs.percent == rhs.percent
    }
    var percent: Double? {
        didSet {
            set()
        }
    }
    func set() {
        expiresDate = Date.now.addingTimeInterval(300*(percent ?? 0))
        complete(expiresDate)
    }
    public var description: String {
        "<FIRST DENDRITE \(self.expiresDate?.description ?? "null")>"
    }
}
