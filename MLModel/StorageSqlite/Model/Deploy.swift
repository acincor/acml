//
//  Deploy.swift
//  MLModel
//
//  Created by Monkey hammer on 8/8/24.
//
public class Deploy: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    @objc public var nerveEnding: NerveEndingModel?
    @objc public var dendrite: DendriteModel?
    @objc var message = [Any]()
    var messageCount: Int = 0
    @objc var expiresDate: Date?
    @objc var cellBody: CellBodyModel?
    public init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    public static func == (lhs: Deploy, rhs: Deploy) -> Bool {
        return lhs.dendrite == rhs.dendrite && lhs.nerveEnding == rhs.nerveEnding && lhs.expiresDate == rhs.expiresDate
    }
    required public init(coder aDecoder: NSCoder) {
        self.nerveEnding = aDecoder.decodeObject(forKey: "nerveEnding") as? NerveEndingModel
        self.dendrite = aDecoder.decodeObject(forKey: "dendrite") as? DendriteModel
        self.message = aDecoder.decodeObject(forKey: "message") as! [Any]
        self.expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as? Date
        self.cellBody = aDecoder.decodeObject(forKey: "cellBody") as? CellBodyModel
    }
    public func encode(with encoder: NSCoder) {
        encoder.encode(self.nerveEnding, forKey: "nerveEnding")
        encoder.encode(self.dendrite, forKey: "dendrite")
        encoder.encode(self.message, forKey: "message")
        encoder.encode(self.expiresDate, forKey: "expiresDate")
        encoder.encode(self.cellBody, forKey: "cellBody")
    }
    public override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    public override var description: String {
        let keys = ["message", "expiresDate", "cellBody"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
