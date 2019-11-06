//
//  MatrixTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/27/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testHorizontalVectorTransposion() {
        let matrix = Matrix(rows: 3, columns: 2, array: [1,2,3,4,5,6])
        let matrix = Matrix(rows: 1, columns: 6, array: <#T##[_]#>)
    }

    func testTransposion() {
        let matrix = Matrix(rows: 3, columns: 2, array: [1,2,3,4,5,6])
        let transposed = matrix.T
        XCTAssertEqual(1, transposed[0,0])
        XCTAssertEqual(3, transposed[0,1])
        XCTAssertEqual(5, transposed[0,2])
        XCTAssertEqual(2, transposed[1,0])
        XCTAssertEqual(4, transposed[1,1])
        XCTAssertEqual(6, transposed[1,2])

        let doubleTransposed = transposed.T
        XCTAssertEqual(matrix, doubleTransposed)
    }

    func testTransposion3x3() {
        // 0 1 2   0 3 6
        // 3 4 5   1 4 7
        // 6 7 8   2 5 8

        let matrix = Matrix(rows: 3, columns: 3, array: [0,1,2,3,4,5,6,7,8])
        let transposed = matrix.T
        XCTAssertEqual(0, transposed[0,0])
        XCTAssertEqual(3, transposed[0,1])
        XCTAssertEqual(6, transposed[0,2])
        XCTAssertEqual(1, transposed[1,0])
        XCTAssertEqual(4, transposed[1,1])
        XCTAssertEqual(7, transposed[1,2])
        XCTAssertEqual(2, transposed[2,0])
        XCTAssertEqual(5, transposed[2,1])
        XCTAssertEqual(8, transposed[2,2])
    }

}
