//
//  NeuralNetworkTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class NeuralNetworkTests: XCTestCase {

    func testQueury() {
        let wihValues = [0.9, 0.3, 0.4, 0.2, 0.8, 0.2, 0.1, 0.5, 0.6]
        let wih: Matrix<Double> = Matrix(rows: 3, columns: 3, array: wihValues)
        let whoValues = [0.3, 0.7, 0.5, 0.6, 0.5, 0.2, 0.8, 0.1, 0.9]
        let who: Matrix<Double> = Matrix(rows: 3, columns: 3, array: whoValues)

        let inMatrix = Matrix.column(elements: [0.9, 0.1, 0.8])
        let hiddenInputs = try! wih.dot(inMatrix)

        XCTAssertEqual(1.16, hiddenInputs[0,0], accuracy: 0.001)
        XCTAssertEqual(0.42, hiddenInputs[1,0], accuracy: 0.001)
        XCTAssertEqual(0.62, hiddenInputs[2,0], accuracy: 0.001)

        let hiddenOutputs = hiddenInputs.apply(sigmoid)

        XCTAssertEqual(0.761, hiddenOutputs[0,0], accuracy: 0.001)
        XCTAssertEqual(0.603, hiddenOutputs[1,0], accuracy: 0.001)
        XCTAssertEqual(0.650, hiddenOutputs[2,0], accuracy: 0.001)


        let finalInputs = try! who.dot(hiddenOutputs)

        XCTAssertEqual(0.975, finalInputs[0,0], accuracy: 0.001)
        XCTAssertEqual(0.888, finalInputs[1,0], accuracy: 0.001)
        XCTAssertEqual(1.254, finalInputs[2,0], accuracy: 0.001)

        let finalOutputs = finalInputs.apply(sigmoid)

        XCTAssertEqual(0.726, finalOutputs[0,0], accuracy: 0.001)
        XCTAssertEqual(0.708, finalOutputs[1,0], accuracy: 0.001)
        XCTAssertEqual(0.778, finalOutputs[2,0], accuracy: 0.001)
    }

    func testQueury2() {
        let wihValues = [0.50896098, 0.56148512, 0.02920713,
                         1.84589072, 0.02305057, -0.42222685,
                         -0.46829533, -0.15183301, -0.12642403]
        let wih: Matrix<Double> = Matrix(rows: 3, columns: 3, array: wihValues)
        let whoValues = [-1.04802266, -0.99832913, 0.20956993,
                         -0.2312622, -0.82053056, -0.71322574,
                         -0.09199362, 0.19261133, -0.20708181]
        let who: Matrix<Double> = Matrix(rows: 3, columns: 3, array: whoValues)

        let inMatrix = Matrix.column(elements: [1.0, 0.5, -1.5])
        let hiddenInputs = try! wih.dot(inMatrix)
        let hiddenOutputs = hiddenInputs.apply(sigmoid)
        let finalInputs = try! who.dot(hiddenOutputs)
        let finalOutputs = finalInputs.apply(sigmoid)
        XCTAssertEqual(0.17560622, finalOutputs[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.2299386, finalOutputs[1,0], accuracy: 0.000001)
        XCTAssertEqual(0.50752515, finalOutputs[2,0], accuracy: 0.000001)
    }

    func testTrain() {
        let learningRate = 0.3
        let wihValues = [-0.04181045, -0.12212647, 0.00297185,
                         -0.30692235, -0.86247053, -0.09246921,
                         0.97641031, 0.49683954, -0.77758329]
        let wih: Matrix<Double> = Matrix(rows: 3, columns: 3, array: wihValues)
        let whoValues = [-0.26168878, 0.20105044, -0.53555119,
                         1.0886597, -0.24852995, -0.35216858,
                         -0.20535956, 0.58141904, -0.66009959]
        var who: Matrix<Double> = Matrix(rows: 3, columns: 3, array: whoValues)

        let inMatrix = Matrix.column(elements: [1.0, 0.5, -1.5])
        let targetsMatrix = Matrix.column(elements: [0.5, 0.5, 0.9])

        let hiddenInputs = try! wih.dot(inMatrix)
        XCTAssertEqual(-0.10733145, hiddenInputs[0,0], accuracy: 0.00000001)
        XCTAssertEqual(-0.5994538, hiddenInputs[1,0], accuracy: 0.00000001)
        XCTAssertEqual( 2.39120502, hiddenInputs[2,0], accuracy: 0.00000001)

        let hiddenOutputs = hiddenInputs.apply(sigmoid)
        XCTAssertEqual(0.47319287, hiddenOutputs[0,0], accuracy: 0.00000001)
        XCTAssertEqual(0.35446867, hiddenOutputs[1,0], accuracy: 0.00000001)
        XCTAssertEqual(0.91615418, hiddenOutputs[2,0], accuracy: 0.00000001)

        let finalInputs = try! who.dot(hiddenOutputs)
        XCTAssertEqual(-0.54321065, finalInputs[0,0], accuracy: 0.00000001)
        XCTAssertEqual(0.10440921, finalInputs[1,0], accuracy: 0.00000001)
        XCTAssertEqual(-0.49583284, finalInputs[2,0], accuracy: 0.00000001)

        let finalOutputs = finalInputs.apply(sigmoid)
        XCTAssertEqual(-0.54321065, finalInputs[0,0], accuracy: 0.00000001)
        XCTAssertEqual(0.10440921, finalInputs[1,0], accuracy: 0.00000001)
        XCTAssertEqual(-0.49583284, finalInputs[2,0], accuracy: 0.00000001)

        // calc error
        let outputErrors = targetsMatrix - finalOutputs
        XCTAssertEqual(0.13255898, outputErrors[0,0], accuracy: 0.00000001)
        XCTAssertEqual(-0.02607862, outputErrors[1,0], accuracy: 0.00000001)
        XCTAssertEqual(0.52147954, outputErrors[2,0], accuracy: 0.00000001)

        let hiddenErrors = try! who.T.dot(outputErrors)
        XCTAssertEqual(-0.17017074, hiddenErrors[0,0], accuracy: 0.00000001)
        XCTAssertEqual(0.33633049, hiddenErrors[1,0], accuracy: 0.00000001)
        XCTAssertEqual(-0.40603648, hiddenErrors[2,0], accuracy: 0.00000001)

        let deltawho = try! learningRate * ((outputErrors * finalOutputs * (1.0 - finalOutputs)).dot(hiddenOutputs.T))
        XCTAssertEqual(0.00437378, deltawho[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.0032764, deltawho[0,1], accuracy: 0.000001)
        XCTAssertEqual(0.00846813, deltawho[0,2], accuracy: 0.000001)
        XCTAssertEqual(-0.000923, deltawho[1,0], accuracy: 0.000001)
        XCTAssertEqual(-0.00069142, deltawho[1,1], accuracy: 0.000001)
        XCTAssertEqual(-0.00178703, deltawho[1,2], accuracy: 0.000001)
        XCTAssertEqual(0.01741458, deltawho[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.01304525, deltawho[2,1], accuracy: 0.000001)
        XCTAssertEqual(0.03371656, deltawho[2,2], accuracy: 0.000001)

        who = who + deltawho
        XCTAssertEqual(-0.257315, who[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.20432684, who[0,1], accuracy: 0.000001)
        XCTAssertEqual(-0.52708306, who[0,2], accuracy: 0.000001)
        XCTAssertEqual(1.0877367, who[1,0], accuracy: 0.000001)
        XCTAssertEqual(-0.24922137, who[1,1], accuracy: 0.000001)
        XCTAssertEqual(-0.35395561, who[1,2], accuracy: 0.000001)
        XCTAssertEqual(-0.18794498, who[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.59446429, who[2,1], accuracy: 0.000001)
        XCTAssertEqual(-0.62638302, who[2,2], accuracy: 0.000001)
    }

    func testDeltaCalculations() {
        let ddMatrix = Matrix.column(elements: [-0.03119937, 0.04271855, 0.1148858])
        let hiddenOutputs = Matrix.column(elements: [0.56853431, 0.15984194, 0.83002983])
        let deltawho = try! ddMatrix.dot(hiddenOutputs.T)
        XCTAssertEqual(-0.01773791, deltawho[0,0], accuracy: 0.000001)
        XCTAssertEqual(-0.00498697, deltawho[0,1], accuracy: 0.000001)
        XCTAssertEqual(-0.02589641, deltawho[0,2], accuracy: 0.000001)
        XCTAssertEqual(0.02428696, deltawho[1,0], accuracy: 0.000001)
        XCTAssertEqual(0.00682822, deltawho[1,1], accuracy: 0.000001)
        XCTAssertEqual(0.03545767, deltawho[1,2], accuracy: 0.000001)
        XCTAssertEqual(0.06531652, deltawho[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.01836357, deltawho[2,1], accuracy: 0.000001)
        XCTAssertEqual(0.09535864, deltawho[2,2], accuracy: 0.000001)
    }

    func testSubstitution() {
        let outputErrors = Matrix.column(elements: [-0.10700494, 0.05924758, 0.29594308])
        let finalOutputs = Matrix.column(elements: [0.60700494, 0.44075242, 0.60405692])
        let sub = outputErrors * finalOutputs * (1.0 - finalOutputs)
        XCTAssertEqual(1, sub.columns)
        XCTAssertEqual(3, sub.rows)
        XCTAssertEqual(-0.02552602, sub[0,0], accuracy: 0.0000001)
        XCTAssertEqual( 0.01460392, sub[1,0], accuracy: 0.0000001)
        XCTAssertEqual( 0.07078135, sub[2,0], accuracy: 0.0000001)
    }

    func testLearningRate() {
        let learningRate = 0.3
        let deltaValues = [0.02978269, 0.02040783, 0.02349084,
                         -0.02060743, -0.01412071, -0.01625393,
                         0.05143526, 0.03524469, 0.04056911]
        let delta: Matrix<Double> = Matrix(rows: 3, columns: 3, array: deltaValues)
        let deltawho = learningRate * delta
        XCTAssertEqual(0.00893481, deltawho[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.00612235, deltawho[0,1], accuracy: 0.000001)
        XCTAssertEqual(0.00704725, deltawho[0,2], accuracy: 0.000001)
        XCTAssertEqual(-0.00618223, deltawho[1,0], accuracy: 0.000001)
        XCTAssertEqual(-0.00423621, deltawho[1,1], accuracy: 0.000001)
        XCTAssertEqual(-0.00487618, deltawho[1,2], accuracy: 0.000001)
        XCTAssertEqual(0.01543058, deltawho[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.01057341, deltawho[2,1], accuracy: 0.000001)
        XCTAssertEqual(0.01217073, deltawho[2,2], accuracy: 0.000001)
    }

    func testDelta() {
        let learningRate = 0.3
        let outputErrors = Matrix.column(elements: [-0.1587249, 0.00714116, 0.58370861])
        let finalOutputs = Matrix.column(elements: [0.6587249 , 0.49285884, 0.31629139])
        let hiddenOutputs = Matrix.column(elements: [0.55875768 , 0.84261875, 0.34559052])
        let deltawho = try! learningRate * ((outputErrors * finalOutputs * (1.0 - finalOutputs)).dot(hiddenOutputs.T))
        XCTAssertEqual(-0.00598134, deltawho[0,0], accuracy: 0.000001)
        XCTAssertEqual(-0.00901999, deltawho[0,1], accuracy: 0.000001)
        XCTAssertEqual(-0.00369945, deltawho[0,2], accuracy: 0.000001)
        XCTAssertEqual(0.0002992, deltawho[1,0], accuracy: 0.000001)
        XCTAssertEqual(0.0004512, deltawho[1,1], accuracy: 0.000001)
        XCTAssertEqual(0.00018506, deltawho[1,2], accuracy: 0.000001)
        XCTAssertEqual(0.0211592, deltawho[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.03190854, deltawho[2,1], accuracy: 0.000001)
        XCTAssertEqual(0.01308692, deltawho[2,2], accuracy: 0.000001)
    }

    func testSum() {
        let whoValues = [-0.26168878, 0.20105044, -0.53555119,
                         1.0886597, -0.24852995, -0.35216858,
                         -0.20535956, 0.58141904, -0.66009959]
        let who: Matrix<Double> = Matrix(rows: 3, columns: 3, array: whoValues)
        print(who)

        let deltaWhoValues = [0.00437378, 0.0032764, 0.00846813,
                               -0.000923, -0.00069142, -0.00178703,
                               0.01741458, 0.01304525, 0.03371656]
        let deltawho: Matrix<Double> = Matrix(rows: 3, columns: 3, array: deltaWhoValues)
        let result = who + deltawho
        XCTAssertEqual(-0.257315, result[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.20432684, result[0,1], accuracy: 0.000001)
        XCTAssertEqual(-0.52708306, result[0,2], accuracy: 0.000001)
        XCTAssertEqual(1.0877367, result[1,0], accuracy: 0.000001)
        XCTAssertEqual(-0.24922137, result[1,1], accuracy: 0.000001)
        XCTAssertEqual(-0.35395561, result[1,2], accuracy: 0.000001)
        XCTAssertEqual(-0.18794498, result[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.59446429, result[2,1], accuracy: 0.000001)
        XCTAssertEqual(-0.62638302, result[2,2], accuracy: 0.000001)
    }

}
