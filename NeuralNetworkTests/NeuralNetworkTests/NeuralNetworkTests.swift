//
//  NeuralNetworkTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class NeuralNetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

}
