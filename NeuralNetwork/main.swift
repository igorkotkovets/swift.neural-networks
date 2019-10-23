//
//  main.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

print("Hello, World!")

let inputNodes = 3
let hiddenNodes = 3
let outputNodes = 3
let learningRate = 0.3

let neuralNetwork = NeuralNetwork(inputNodes: inputNodes, hiddenNodes: hiddenNodes, outputNodes: outputNodes, learningRate: learningRate)
let result = try? neuralNetwork.query(inputs: 1.0, 0.5, -1.5)
print(result)


