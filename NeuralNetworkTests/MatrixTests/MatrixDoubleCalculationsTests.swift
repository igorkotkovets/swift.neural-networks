//
//  MatrixDoubleCalculationsTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/29/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixDoubleCalculationsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMatrixDotMultiplication() {
        let first = Matrix(rows: 1, columns: 4, array: [0.0, 1.0, 2.0, 3.0])
        let second = Matrix(rows: 4, columns: 1, array: [0.0, 1.0, 2.0, 3.0])
        let result = try? first.dot(second)
        XCTAssertNotNil(result)
    }

    func testMatrixDotMultiplication2() {
        let first = Matrix(rows: 2, columns: 3, array: [0.0, 1.0, 2.0, 3.0, 4.0, 5.0])
        let second = Matrix(rows: 3, columns: 2, array: [0.0, 1.0, 2.0, 3.0, 4.0, 5.0])
        let result = try? first.dot(second)
        XCTAssertNotNil(result)
        XCTAssertEqual(10, result![0,0])
        XCTAssertEqual(13, result![0,1])
        XCTAssertEqual(28, result![1,0])
        XCTAssertEqual(40, result![1,1])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
