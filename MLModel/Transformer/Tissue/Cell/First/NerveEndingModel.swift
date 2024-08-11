//
//  NerveEndingModel.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class NerveEndingModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    required public init(coder aDecoder: NSCoder) {
        self.percent = aDecoder.decodeDouble(forKey: "percent")
        self.deploy = aDecoder.decodeObject(forKey: "deploy") as? Deploy
    }
    public func encode(with encoder: NSCoder) {
        encoder.encode(self.deploy, forKey: "deploy")
        encoder.encode(self.percent, forKey: "percent")
    }
    @objc public var deploy: Deploy?
    public init(percent: Double = 1.00, deploy: Deploy? = nil){
        self.percent = percent
        self.deploy = deploy
        super.init()
        set()
    }
    func set() {
        deploy?.expiresDate = Date.now.addingTimeInterval(300*percent)
    }
    public static func == (lhs: NerveEndingModel, rhs: NerveEndingModel) -> Bool {
        return lhs.deploy == rhs.deploy
    }
    @objc func send() {
        if Date.now.timeIntervalSince1970 > deploy?.expiresDate?.timeIntervalSince1970 ?? Date.now.timeIntervalSince1970 {
            self.percent = 0
            self.deploy?.dendrite = nil
            return
        } else {
            self.percent = percent * exp(-(deploy?.expiresDate?.timeIntervalSince1970 ?? Date.now.timeIntervalSince1970) * 0.2)
        }
        for i in deploy?.dendrite?.deploy?.message ?? []{
            deploy?.message?.append(i)
        }
    }
    @objc var percent: Double{
        didSet {
            set()
        }
    }
    public override var description: String {
        "<FIRST NERVEENDING \(deploy?.description ?? NSNull.description())>"
    }
}
