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

    func testMatrixCreation3x3() {
        let array = [1,0,0,0,1,0,0,0,1]
        let matrix = Matrix(rows: 3, columns: 3, array: array)
        XCTAssertEqual(matrix[0,0], 1)
        XCTAssertEqual(matrix[0,1], 0)
        XCTAssertEqual(matrix[0,2], 0)
        XCTAssertEqual(matrix[1,0], 0)
        XCTAssertEqual(matrix[1,1], 1)
        XCTAssertEqual(matrix[1,2], 0)
        XCTAssertEqual(matrix[2,0], 0)
        XCTAssertEqual(matrix[2,1], 0)
        XCTAssertEqual(matrix[2,2], 1)
    }

}
