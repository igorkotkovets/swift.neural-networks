//
//  NeuralNetwork.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import GameplayKit

protocol NeuralNetworkInput {
    func train(inputs: [Double], targets: [Double]) throws
    func query(inputs: [Double]) throws -> Matrix<Double>
}

class NeuralNetwork: NeuralNetworkInput {
    let inputNodes: Int
    let hiddenNodes: Int
    let outputNodes: Int
    let learningRate: Double
    var wih: Matrix<Double>
    var who: Matrix<Double>
    let activationFunction: (Matrix) -> Matrix = sigmoid

    init(inputNodes: Int, hiddenNodes: Int, outputNodes: Int, learningRate: Double) {
        self.inputNodes = inputNodes
        self.hiddenNodes = hiddenNodes
        self.outputNodes = outputNodes
        self.learningRate = learningRate

        let random = GKRandomSource()
        let ihDeviation = powf(Float(inputNodes), -0.5)
        let ihDistribution = NormalDistribution(randomSource: random, mean: 0.5, deviation: ihDeviation)
        let wihArray = (0..<hiddenNodes*inputNodes).map { _ in return ihDistribution.nextDouble()-0.5 }
        self.wih = Matrix(rows: hiddenNodes, columns: inputNodes, array: wihArray)
        print("self.wih = \(self.wih)")

        let hoDeviation = powf(Float(inputNodes), -0.5)
        let hoDistribution = NormalDistribution(randomSource: random, mean: 0.5, deviation: hoDeviation)
        let wohArray = (0..<outputNodes*hiddenNodes).map { _ in return hoDistribution.nextDouble()-0.5 }
        self.who = Matrix(rows: outputNodes, columns: hiddenNodes, array: wohArray)
        print("self.who = \(self.who)")
    }

    func train(inputs: [Double], targets: [Double]) throws {
        let inMatrix = Matrix.column(elements: inputs)
        let targetsMatrix = Matrix.column(elements: targets)

        // calc input signals for hidden layer
        let hiddenInputs = try self.wih.dot(inMatrix)
        // calc output signals for hidden layer
        let hiddenOutputs = hiddenInputs.apply(self.activationFunction)
        // calc input signals for output layer
        let finalInputs = try self.who.dot(hiddenOutputs)
        // calc output signals for output layer
        let finalOutputs = finalInputs.apply(self.activationFunction)

        // calc error
        let outputErrors = targetsMatrix - finalOutputs
        let hiddenErrors = try self.who.T.dot(outputErrors)

        let deltawho = try self.learningRate * ((outputErrors * finalOutputs * (1.0 - finalOutputs)).dot(hiddenOutputs.T))
        self.who = self.who + deltawho

        let deltawih = try self.learningRate * ((hiddenErrors * hiddenOutputs * (1.0 - hiddenOutputs)).dot(inMatrix.T))
        self.wih = self.wih + deltawih
    }

    func query(inputs: [Double]) throws -> Matrix<Double> {
        let inMatrix = Matrix.column(elements: inputs)
        // calc input signals for hidden layer
        let hiddenInputs = try self.wih.dot(inMatrix)
        // calc output signals for hidden layer
        let hiddenOutputs = hiddenInputs.apply(self.activationFunction)
        // calc input signals for output layer
        let finalInputs = try self.who.dot(hiddenOutputs)
        // calc output signals for output layer
        let finalOutputs = finalInputs.apply(self.activationFunction)
        
        return finalOutputs

    }
}


