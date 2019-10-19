//
//  NeuralNetworkTests.swift
//  NeuralNetworkTests
//
//  Created by igork on 6/8/19.
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

    func testThatNeuralNetworkWorks() {
        let network = NeuralNetwork(inputNodes: 3, hiddenNodes: 3, outputNodes: 3, learningRate: 0.3)
        let matrix = try! network.query(inputs: [1.0, 0.5, -1.5])
        print("\(matrix)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
