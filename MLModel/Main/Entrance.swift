//
//  Entrance.swift
//  MLModel
//
//  Created by Monkey hammer on 8/9/24.
//
func hasDuplicates<T: Hashable>(array: [T]) -> Bool {
    return Set(array).count != array.count
}
public func loadDeploy() throws -> Brain {
    //neuron tissues begin defining
    let nerveTissues = try DeployDAL.loadStatus()
    //brain begins defining
    let brain = Brain(nerveTissues: nerveTissues)
    //print the result
    return brain
}
var queue = Queue()
public func add(_ messages: [[[Any]]], _ n: Int, _ clear: Bool) throws -> Brain {
    if clear {
        DeployDAL.clearDataCache()
    }
    var brain = [[String:Any]]()
    var cellBody = DeployDAL.loadNewCellBody!
    var id = DeployDAL.loadNewId
    for s in 0 ..< messages.count {
        var datas = [NeuronCell]()
        let tId = id
        id = DeployDAL.loadNewId
        while tId == id {
            id = DeployDAL.loadNewId
        }
        for x in 0 ..< messages[s].count {
            let tcellBody = cellBody
            cellBody = DeployDAL.loadNewCellBody!
            while tcellBody == cellBody {
                cellBody = DeployDAL.loadNewCellBody!
            }
            var data = [String:Any]()
            data["cellBody"] = cellBody
            var nerveEndings = [NerveEndingModel]()
            var dendrites = [DendriteModel]()
            for _ in 0 ..< n {
                nerveEndings.append(NerveEndingModel(deploy:Deploy(dict: data)))
                dendrites.append(DendriteModel(deploy:Deploy(dict: data)))
            }
            datas.append(NeuronCell(cellBody: cellBody, dendrites: dendrites, nerveEndings: nerveEndings, msg: messages[s][x]))
        }
        brain.append(["id": id,"nerveTissue":NerveTissue(neuronCells: datas),"create_at":Date.now.description])
    }
    for s in 0 ..< messages.count {
        guard let datas = brain[s]["nerveTissue"] as? NerveTissue else {
            continue
        }
        for i in 0 ..< messages[s].count {
            let cell = datas.neuronCells[i]
            if i != 0 {
                let leastCell = datas.neuronCells[i-1]
                let dendrites = cell.dendrites
                for s in 0 ..< n {
                    dendrites[s].deploy?.nerveEnding = leastCell.nerveEndings[s]
                }
                cell.dendrites = dendrites
            }
            if i < messages[s].count - 1 {
                let nextCell = datas.neuronCells[i+1]
                let nerveEndings = cell.nerveEndings
                for s in 0 ..< n {
                    nerveEndings[s].deploy?.dendrite = nextCell.dendrites[s]
                }
                cell.nerveEndings = nerveEndings
            }
            datas.neuronCells[i] = cell
        }
        brain[s]["nerveTissue"] = datas
    }
    DeployDAL.saveCache(array: brain)
    let loadedBrain = try loadDeploy()
    return loadedBrain
}
public func rand(_ nerveTissuesCount: Int, _ messagesCount: Int, _ range: Int, _ neuronCellsCount: Int,_ n: Int, _ clear: Bool) throws -> Brain {
    var nerveTissues = [[[Any]]]()
    for _ in 0 ..< nerveTissuesCount {
        var messages = [[Any]]()
        for _ in 0 ..< neuronCellsCount {
            var message = [Any]()
            for _ in 0 ..< messagesCount {
                message.append(Int.random(in: 0...range))
            }
            messages.append(message)
        }
        nerveTissues.append(messages)
    }
    return try add(nerveTissues, n, clear)
}
public class Queue {
    /// the max times of retries when the task failing
    var taskList = [QueueTask]()
    public func addOperation(_ op: QueueTask) {
        taskList.append(op)
    }
    func runTask(_ finished: @escaping (([[[Any]]])->())) {
        var tasks = [[[Any]]]()
        for task in taskList {
            tasks.append(task.runTask())
        }
        finished(tasks)
        taskList.removeAll()
    }
}
public class QueueTask {
    public var closure: (() -> ([[Any]]))
    init(closure: @escaping (() -> ([[Any]]))) {
        self.closure = closure
    }
    func runTask() -> [[Any]] {
        return closure()
    }
}
