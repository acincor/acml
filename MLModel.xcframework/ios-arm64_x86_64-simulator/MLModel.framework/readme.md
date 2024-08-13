# ``MLModel``

A Safety Model about simulate brain

## Overview

A Safety Model about simulate brain

## Transformer
    
### DNAModel
```
public class DNAModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder)
    public required init?(coder: NSCoder)
    public init(rnaId: [Int]) throws
    public override var description: String
    public static func == (lhs: DNAModel, rhs: DNAModel) -> Bool
}
```
### NucleusModel
```
public class NucleusModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder)
    public required init?(coder: NSCoder)
    public init(dnas: [DNAModel]) throws
    public static func == (lhs: NucleusModel, rhs: NucleusModel) -> Bool
    public override var description: String
}
```
    
### CellBodyModel
```
public class CellBodyModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder)
    public required init?(coder: NSCoder)
    public init(nucleus: NucleusModel)
    public static func == (lhs: CellBodyModel, rhs: CellBodyModel) -> Bool
    public override var description: String
}
```
    
### DendriteModel
```
public class DendriteModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    required public init(coder aDecoder: NSCoder)
    public func encode(with encoder: NSCoder)
    @objc public var deploy: Deploy?
    public init(percent: Double = 1.00, deploy: Deploy? = nil)
    @objc func receive()
    public static func == (lhs: DendriteModel, rhs: DendriteModel) -> Bool
    public override var description: String
}
```
    
### NerveEndingModel
```
public class NerveEndingModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    required public init(coder aDecoder: NSCoder)
    public func encode(with encoder: NSCoder)
    @objc public var deploy: Deploy?
    public init(percent: Double = 1.00, deploy: Deploy? = nil)
    @objc func send()
    public static func == (lhs: NerveEndingModel, rhs: NerveEndingModel) -> Bool
    public override var description: String
}
```
    
### NeuronCell
```
public class NeuronCell: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder)
    public required init?(coder: NSCoder)
    public func build()
    public var dendrites: [DendriteModel]
    public var nerveEndings: [NerveEndingModel]
    public override var description: String
    public static func == (lhs: NeuronCell, rhs: NeuronCell) -> Bool
    public init(cellBody: CellBodyModel, dendrites: [DendriteModel], nerveEndings: [NerveEndingModel], msg: [Any])
}
```
    
### NeuronTissue
```
public class NerveTissue: CustomStringConvertible {
    public init(neuronCells: [NeuronCell])
    public func build()
    public var msgs: [Any]
    public var description: String
}
```
    
### Brain
```
public class Brain: CustomStringConvertible {
    public init(nerveTissues: [NerveTissue])
    public func build()
    public var msgs: [Any]
    public var description: String
}
```

## StorageSqlite

### DeployDAL
```
open class DeployDAL {
    public class func clearDataCache()
    public class func removeCache(_ statusId: Int)
    public static func collectCellBody()
    public static var loadNewCellBody: CellBodyModel?
    public static var expiresDates = [Int:Date]()
    public class func saveSingleCache(array dict: [String:Any])
    public class func saveCache(array data: [[String:Any]])
    public class func loadStatus() throws -> [NeuronCell]
}
```

### Deploy
```
public class Deploy: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    public static func == (lhs: Deploy, rhs: Deploy) -> Bool
    required public init(coder aDecoder: NSCoder)
    @objc public var nerveEnding: NerveEndingModel?
    public init(dict: [String: Any])
    @objc public var dendrite: DendriteModel?
    public func encode(with encoder: NSCoder)
    public override func setValue(_ value: Any?, forUndefinedKey key: String)
    public override var description: String
}
```
### SqliteManager
```
Private Class
```
## Entrance
```
public func loadDeploy() throws -> Brain
public func add(_ messages: [[Any]], _ n: Int, _ clear: Bool, _ build: Bool) throws -> Brain
```
# HOW TO GENERATE A BRAIN WITH RANDOM MESSAGES
```
add(_ messages: [[Any]], _ n: Int, _ clear: Bool, _ build: Bool)
```
# HOW TO OUTPUT MSGS ON CONSOLE
```
NSLog(brain.msgs)
```
