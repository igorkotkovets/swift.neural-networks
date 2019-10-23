//
//  FileInputStreamTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class FileInputStreamTests: XCTestCase {

    override func setUp() {
        let pathToTrainCSV = Bundle.main.path(forResource: "mnist_train_100", ofType: "csv")
        print(pathToTrainCSV)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
