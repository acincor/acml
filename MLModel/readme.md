# ML Model
# A Model about simulate brain
# RNA
**Parameter:id Type: Identifier**
# Defined
```
var ids = [Int]()
func id() -> Int{
    var iden = Int.random(in: 1..<100000000000)
    while(ids.contains(iden)) {
        iden = Int.random(in: 1..<100000000000)
    }
    self.ids.append(iden)
    return iden
}
var rnas = [
    RNAModel(id: id()),
    RNAModel(id:id())
]
var nextRnas = [
    RNAModel(id: id()),
    RNAModel(id: id())
]
```

# DNA
**Parameter:[RNA] Type: Identifier**
# Defined
```
var dnas = [
            try DNAModel(rnas: rnas)
            ]
var nextDnas = [
                try DNAModel(rnas: nextRnas)
                ]
```

# Nucleus
#Parameter
**dnas: [DNA]**
#Type
**Identifier**
# Defined
```
let nucleus = try NucleusModel(dnas: dnas)
let nextNucleus = try NucleusModel(dnas: nextDnas)
```

# cellBody
#Parameter
**nucleus: Nucleus**
#Type
**Identifier**
# Defined
```
let cellBody = try CellBodyModel(nucleus: nucleus)
let nextCellBody = try CellBodyModel(nucleus: nextNucleus)
```

# Message Protocol
#Parameter
**expiresDate: Date?
    geT: (() -> (Date?))
    complete: ((Date?) -> ())
    percent: Double?**
#Type
**Protocol**

# Dendrite
#Parameter
**nerveEnding: NerveEndingModel?
    message: String
    expiresDate: Date?
    geT: (() -> (Date?))
    complete: ((Date?) -> ())
    percent: Double?**
#Type
**MessageProtocol**
# Defined
```
//For example
let expiresDates = [Date]()
let dendrites = [
                try DendriteModel(percent: 1, get: 
                            {
                            self.expiresDates[0] 
                            }, complete: 
                            { date in
                            self.expiresDates.append(date ?? Date())
                            })
                ]
let nextDendrites = [
                    try DendriteModel(percent: 0.4, get: 
                            { 
                            self.expiresDates[1] 
                            }, complete: 
                            { date in self.expiresDates.append(date ?? Date()) 
                            })
                    ]
```

# NerveEnding
#Parameter
**dendrite: DendriteModel?
    message: String
    expiresDate: Date?
    geT: (() -> (Date?))
    complete: ((Date?) -> ())
    percent: Double?**
#Type
**MessageProtocol**
# Defined
```
//...... dendrites definded
let nerveEndings = [
                    try NerveEndingModel(dendrite: nextDendrites[0], percent: 0.9,get: { self.expiresDates[2] },complete: {date in self.expiresDates.append(date ?? Date())})
                    ]
nextDendrites[0].nerveEnding = nerveEndings[0] // binded
let nextNerveEndings = [
                        try NerveEndingModel(percent: 0.3,get: { self.expiresDates[3] }, complete: {date in self.expiresDates.append(date ?? Date())})
                        ]
```

# NeuronCell
#Parameter
**msg: String
    dendrites: [DendriteModel]
    nerveEndings: [NerveEndingModel]
    cellBody: CellBodyModel**
#Type
**MessageProtocol**
# Defined
```
let neuronCells = [
                    NeuronCell(cellBody: cellBody, dendrites: dendrites, nerveEndings: nerveEndings, msg: "xcode"),
                    NeuronCell(cellBody: nextCellBody, dendrites: nextDendrites, nerveEndings: nextNerveEndings, msg: "是一种集成环境式IDE")
                   ]
```

# NeuronTissue
#Parameter
**neuronCells: [NeuronCell]**
#Type
**CustomStringConvertiable**
# Defined
```
let nerveTissues = [NerveTissue(neuronCells: neuronCells)]
```

# Brain
#Parameter
**nerveTissues: [NerveTissue]**
#Type
**CustomStringConvertiable**
# Defined
```
let brain = Brain(nerveTissues: nerveTissues)
```

# HOW TO OUTPUT MSGS ON CONSOLE
```
NSLog(brain.msgs.last?.last ?? "null")
```
