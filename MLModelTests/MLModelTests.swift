//
//  MLModelTests.swift
//  MLModelTests
//
//  Created by Monkey hammer on 7/31/24.
//

import Testing
@testable import MLModel
class expires {
    static let shared = expires()
    var expiresDates = [Date]()
    func example() async throws {
        /*
        Example
         Organ: Brain
         Tissue: NerveTissue
         Cell: NeuronCell
         First: CellBodyModel, DendriteModel, NerveEndingModel
         Second: NucleusModel
         Third: DNAModel
         Fourth: RNAModel
         */
        //the parameter that name is `dnas` begins defining
        let rnas = [
                    RNAModel(id: id()),
                    RNAModel(id: id())
                    ] // rnas action
        let dnas = [
            try DNAModel(rnas: rnas)
                    ] // dnas action
        let nucleus = try NucleusModel(dnas: dnas) // the incoming parameter of the nucleus is `dnas`
        //the parameter that name is `dnas` begins defining
        let nextRnas = [
                    RNAModel(id: id()),
                    RNAModel(id: id())
                    ] // rnas action
        let nextDnas = [
            try DNAModel(rnas: nextRnas)
                    ] // dnas action
        let nextNucleus = try NucleusModel(dnas: nextDnas) // the incoming parameter of the nucleus is `nextCleus`
        //done.
        //dendrites begin defining
        let dendrites = [
            try DendriteModel(percent: 1, get: { self.expiresDates[0] }, complete: { date in
                self.expiresDates.append(date ?? Date())
            })
                        ]
        //next dendrites begin defining
        let nextDendrites = [
            try DendriteModel(percent: 0.4, get: { self.expiresDates[1] }, complete: { date in self.expiresDates.append(date ?? Date()) })
            ]
        //nerve endings begin defining
        let nerveEndings = [
            try NerveEndingModel(dendrite: nextDendrites[0], percent: 0.9,get: { self.expiresDates[2] },complete: {date in self.expiresDates.append(date ?? Date())})
                            ]
        nextDendrites[0].nerveEnding = nerveEndings[0]
        let nextNerveEndings = [
            try NerveEndingModel(percent: 0.3,get: { self.expiresDates[3] }, complete: {date in self.expiresDates.append(date ?? Date())})
                            ]
        //cell body begins defining
        let cellBody = try CellBodyModel(nucleus: nucleus)
        //next cell body begins defining
        let nextCellBody = try CellBodyModel(nucleus: nextNucleus)
        //neuron cells begin defining
        let neuronCells = [
            NeuronCell(cellBody: cellBody, dendrites: dendrites, nerveEndings: nerveEndings, msg: "xcode"),
            NeuronCell(cellBody: nextCellBody, dendrites: nextDendrites, nerveEndings: nextNerveEndings, msg: "是一种集成环境式IDE")
                ]
        //neuron tissues begin defining
        let nerveTissues = [NerveTissue(neuronCells: neuronCells)]
        //brain begins defining
        let brain = Brain(nerveTissues: nerveTissues)
        //brain begins building
        brain.build()
        //print the result
        print(brain.msgs.last?.last ?? "null")
    }
    var ids = [Int]()
    func id() -> Int{
        var iden = Int.random(in: 1..<100000000000)
        while(ids.contains(iden)) {
            iden = Int.random(in: 1..<100000000000)
        }
        self.ids.append(iden)
        return iden
    }
    
}
struct MLModelTests {
    @Test mutating func example() async throws {
        try await expires.shared.example()
    }
}
