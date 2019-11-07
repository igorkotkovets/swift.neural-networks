//
//  NormalDistribution.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 11/6/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import GameplayKit

class NormalDistribution {
    private let randomSource: GKRandomSource
    let mean: Float
    let deviation: Float

    init(randomSource: GKRandomSource, mean: Float, deviation: Float) {
        precondition(deviation >= 0)
        self.randomSource = randomSource
        self.mean = mean
        self.deviation = deviation
    }

    func nextFloat() -> Float {
        guard deviation > 0 else { return mean }

        let x1 = randomSource.nextUniform()
        let x2 = randomSource.nextUniform()
        let z1 = sqrt(-2 * log(x1)) * cos(2 * Float.pi * x2)

        return z1 * deviation + mean
    }

    func nextDouble() -> Double {
        return Double(nextFloat())
    }
}
