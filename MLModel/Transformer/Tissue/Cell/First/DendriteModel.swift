//
//  DendriteModel.swift
//  MLModel
//
//  Created by Monkey hammer on 8/1/24.
//

public class DendriteModel: NSObject, NSSecureCoding {
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
    @objc func receive() {
        if Date.now.timeIntervalSince1970 > self.deploy?.expiresDate?.timeIntervalSince1970 ?? Date.now.timeIntervalSince1970 {
            self.percent = 0
            self.deploy?.nerveEnding = nil
            return
        } else {
            self.percent = self.percent * exp(-(self.deploy?.expiresDate?.timeIntervalSince1970 ?? Date.now.timeIntervalSince1970) * 0.2)
        }
        self.set()
        guard let message = self.deploy?.nerveEnding?.deploy?.message else {
            return
        }
        if message.isEmpty {
            return
        }
        let contiguous = ContiguousArray(message)
        contiguous.withUnsafeBufferPointer { buffer in
            let pointer = buffer.baseAddress!
            self.deploy?.message.removeAll()
            for i in 0..<contiguous.count {
                self.deploy?.message.append(pointer[i])
            }
        }
        /*
        queue.addOperation(QueueTask(closure: {
            DispatchQueue.global(qos: .background).async {
            }
            return self.deploy?.message ?? []
        }))
         */
    }
    @objc var percent: Double {
        didSet {
            set()
        }
    }
    func set() {
        deploy?.expiresDate = Date.now.addingTimeInterval(300*percent)
    }
    public static func == (lhs: DendriteModel, rhs: DendriteModel) -> Bool {
        return lhs.deploy == rhs.deploy
    }
    public override var description: String {
        "<FIRST DENDRITE \(deploy?.description ?? NSNull().description)>"
    }
}
