//
//  ServicesPool.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Swinject
import Foundation

protocol ServicesPoolInput {
    func startNeuralNetwork()
}

class ServicesPool: ServicesPoolInput {
    private let resolver: Resolver
    private var _neuralNetwork: NeuralNetworkInput?

    init(withResolver resolver: Resolver) {
        self.resolver = resolver
    }

    func startNeuralNetwork() {
        if _neuralNetwork == nil {
            let inputNodes = 3
            let hiddenNodes = 3
            let outputNodes = 3
            let learningRate = 0.3
            _neuralNetwork = NeuralNetwork(inputNodes: inputNodes, hiddenNodes: hiddenNodes, outputNodes: outputNodes, learningRate: learningRate)
        }
    }

}
