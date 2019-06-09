//
//  MatrixTests.swift
//  NeuralNetworkTests
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {

    func testThatCreateIntMatrix() {
        var matrix = Matrix<Int>(rows: 10, columns: 10, defaultValue: 0)
        matrix[0,0] = 1
        XCTAssertEqual(matrix[0,0], 1)
        matrix[1,1] = 2
        XCTAssertEqual(matrix[1,1], 2)
    }

    func testThatCreateDoubleMatrix() {
        var dblMatrix = Matrix(rows: 5, columns: 5, random: (1, 1))
        
    }

    func testThatIterateIntMatrix() {
        var matrix = Matrix<Int>(rows: 3, columns: 3, defaultValue: 5)
        var count = 0
        for element in matrix {
            count += 1
        }

        XCTAssertEqual(count, 9)
    }

    func testThatMultMatrix() {
        var matrix = Matrix<Double>(rows: 3, columns: 3, defaultValue: 3)
        let matrix9 = 3 * matrix
        XCTAssertEqual(matrix9[0,0], 9.0)
    }

    func testThatSigmoidMatrix() {
        var matrix = Matrix<Double>(rows: 2, columns: 2, defaultValue: 3)
        print(matrix)
        let matrix9 = sigmoid(matrix)
        print(matrix9)
    }

    func testThatMultiplyMatrixes() {
        let firstArray = [1.0, 2.0, 3.0, 4.0]
        let first = Matrix(rows: 2, columns: 2, array: firstArray)

        let secondArray = [5.0, 6.0, 7.0, 8.0]
        let second = Matrix(rows: 2, columns: 2, array: secondArray)

        let result = first*second
        XCTAssertEqual(19, result[0,0])
        XCTAssertEqual(22, result[0,1])
    }

    func testThatTransformMatrix() {
        let array = [1.0, 2.0, 3.0, 4.0]
        let matrix = Matrix(rows: 1, columns: 4, array: array)
        let transformed = matrix.transformed()
        XCTAssertEqual(1.0, transformed[0,0])
        XCTAssertEqual(2.0, transformed[1,0])
        XCTAssertEqual(3.0, transformed[2,0])
        XCTAssertEqual(4.0, transformed[3,0])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
