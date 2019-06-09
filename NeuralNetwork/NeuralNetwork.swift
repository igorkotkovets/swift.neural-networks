//
//  NeuralNetwork.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

class NeuralNetwork {
    let inputNodes: Int
    let hiddenNodes: Int
    let outputNodes: Int
    let learningRate: Double
    let wih: Matrix<Double>
    let who: Matrix<Double>

    init(inputNodes: Int, hiddenNodes: Int, outputNodes: Int, learningRate: Double) {
        self.inputNodes = inputNodes
        self.hiddenNodes = hiddenNodes
        self.outputNodes = outputNodes
        self.learningRate = learningRate
        wih = Matrix(rows: hiddenNodes, columns: inputNodes, random: (-0.5, 0.5))
        who = Matrix(rows: outputNodes, columns: hiddenNodes, random: (-0.5, 0.5))
    }

    func train() {

    }

    func query(inputs: Matrix<Double>) {
        let hiddenInputs = self.wih*inputs
        let hiddenOutputs = sigmoid(hiddenInputs)
        let finalInputs = self.who*hiddenOutputs
        let finalOutputs = sigmoid(finalInputs)
    }
}
