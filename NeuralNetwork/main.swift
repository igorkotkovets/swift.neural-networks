//
//  main.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

print("Hello, World!")

let neuralNetwork = NeuralNetwork(inputNodes: 3, hiddenNodes: 3, outputNodes: 3, learningRate: 0.3)
let matrix = Matrix(rows: 3, columns: 3, random: (-1,1))
print(matrix)

