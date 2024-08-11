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
    let cells = try DeployDAL.loadStatus()
    //neuron tissues begin defining
    let nerveTissues = [NerveTissue(neuronCells: cells)]
    //brain begins defining
    let brain = Brain(nerveTissues: nerveTissues)
    //print the result
    return brain
}
public func rand(_ range: Double, _ n: Int, _ messagesCount: Int, _ neuronCellsCount: Int, _ clear: Bool, _ build: Bool) throws -> Brain {
    if clear {
        DeployDAL.clearDataCache()
    }
    var datas = [[String:Any]]()
    var cellBody = DeployDAL.loadNewCellBody!
    for _ in 0 ..< neuronCellsCount {
        var messages = [Double]()
        for _ in 0 ..< messagesCount {
            messages.append(Double.random(in: 0...range))
        }
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
        datas.append(["cell":NeuronCell(cellBody: cellBody, dendrites: dendrites, nerveEndings: nerveEndings, msg: messages),"create_at":Date.now.description])
    }
    for i in 0 ..< neuronCellsCount {
        guard let cell = datas[i]["cell"] as? NeuronCell else{
            continue
        }
        if i != 0 {
            guard let leastCell = datas[i-1]["cell"] as? NeuronCell else {
                continue
            }
            let dendrites = cell.dendrites
            for s in 0 ..< n {
                dendrites[s].deploy?.nerveEnding = leastCell.nerveEndings[s]
            }
            cell.dendrites = dendrites
            datas[i]["cell"] = cell
        }
        if i < n - 1 {
            guard let nextCell = datas[i+1]["cell"] as? NeuronCell else {
                continue
            }
            let nerveEndings = cell.nerveEndings
            for s in 0 ..< n {
                nerveEndings[s].deploy?.dendrite = nextCell.dendrites[s]
            }
            cell.nerveEndings = nerveEndings
            datas[i]["cell"] = cell
        }
        if build {
            cell.build()
        }
    }
    DeployDAL.saveCache(array: datas)
    return try loadDeploy()
}
