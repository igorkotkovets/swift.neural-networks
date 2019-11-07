//
//  MatrixTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/27/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {

    func testHorizontalVectorTransposion() {
        let matrix = Matrix(rows: 1, columns: 6, array: [1,2,3,4,5,6])
        let transformed = matrix.T
        XCTAssertEqual(1, transformed[0,0])
        XCTAssertEqual(2, transformed[1,0])
        XCTAssertEqual(3, transformed[2,0])
        XCTAssertEqual(4, transformed[3,0])
        XCTAssertEqual(5, transformed[4,0])
        XCTAssertEqual(6, transformed[5,0])

        let doubleTransposed = transformed.T
        XCTAssertEqual(matrix, doubleTransposed)
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

    func testCreation() {
        let whoValues = [-0.26168878, 0.20105044, -0.53555119,
                         1.0886597, -0.24852995, -0.35216858,
                         -0.20535956, 0.58141904, -0.66009959]
        let who: Matrix<Double> = Matrix(rows: 3, columns: 3, array: whoValues)
        XCTAssertEqual(-0.26168878, who[0,0], accuracy: 0.000001)
        XCTAssertEqual(0.20105044, who[0,1], accuracy: 0.000001)
        XCTAssertEqual(-0.53555119, who[0,2], accuracy: 0.000001)
        XCTAssertEqual(1.0886597, who[1,0], accuracy: 0.000001)
        XCTAssertEqual(-0.24852995, who[1,1], accuracy: 0.000001)
        XCTAssertEqual(-0.35216858, who[1,2], accuracy: 0.000001)
        XCTAssertEqual(-0.20535956, who[2,0], accuracy: 0.000001)
        XCTAssertEqual(0.58141904, who[2,1], accuracy: 0.000001)
        XCTAssertEqual(-0.66009959, who[2,2], accuracy: 0.000001)
    }

}
