//
//  MatrixDoubleCalculationsTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/29/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixDoubleCalculationsTests: XCTestCase {

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

    func testNumberDivideToRow() {
        let matrix = Matrix<Double>(rows: 1, columns: 4, array: [1, 2, 4, 8])
        let result = 1.0 / matrix
        XCTAssertEqual(1, result[0,0])
        XCTAssertEqual(0.5, result[0,1])
        XCTAssertEqual(0.25, result[0,2])
        XCTAssertEqual(0.125, result[0,3])
    }

    func testNumberDivideToColumn() {
        let matrix = Matrix<Double>(rows: 4, columns: 1, array: [1, 2, 4, 8])
        let result = 1.0 / matrix
        XCTAssertEqual(1, result[0,0])
        XCTAssertEqual(0.5, result[1,0])
        XCTAssertEqual(0.25, result[2,0])
        XCTAssertEqual(0.125, result[3,0])
    }

    func testExpFunction() {
        let matrix = Matrix<Double>(rows: 1, columns: 1, array: [2.3])
        let result = exp(-matrix)
        XCTAssertEqual(0.10026, result[0,0], accuracy: 0.00001)
    }

    func testSumPlusExpFunction() {
        let matrix = Matrix<Double>(rows: 1, columns: 1, array: [2.3])
        let result = 1.0 + exp(-matrix)
        XCTAssertEqual(1.10026, result[0,0], accuracy: 0.00001)
    }

    func testOneDivToSumPlusExpFunction() {
        let matrix = Matrix<Double>(rows: 1, columns: 1, array: [2.3])
        let result = 1.0 / (1.0 + exp(-matrix))
        XCTAssertEqual(0.90887, result[0,0], accuracy: 0.00001)
    }

    func testSigmoidFunction() {
        let matrix = Matrix<Double>(rows: 1, columns: 1, array: [2.3])
        let result = sigmoid(matrix)
        XCTAssertEqual(0.90887, result[0,0], accuracy: 0.00001)

        let result2 = matrix.apply(sigmoid)
        XCTAssertEqual(result, result2)
    }

    func testMatrixMultiplications() {
        let first = Matrix<Double>(rows: 1, columns: 4, array: [1, 2, 3, 4])
        let second = Matrix<Double>(rows: 1, columns: 4, array: [2, 3, 4, 5])
        let result = first*second
        XCTAssertEqual(2, result[0,0])
        XCTAssertEqual(6, result[0,1])
        XCTAssertEqual(12, result[0,2])
        XCTAssertEqual(20, result[0,3])
    }

    func testMatrixMinusMatrix() {
        let first = Matrix<Double>(rows: 1, columns: 4, array: [1, 2, -3, 4])
        let second = Matrix<Double>(rows: 1, columns: 4, array: [2, 3, 4, -5])
        let result = first - second
        XCTAssertEqual(-1, result[0,0])
        XCTAssertEqual(-1, result[0,1])
        XCTAssertEqual(-7, result[0,2])
        XCTAssertEqual(9, result[0,3])
    }

//    func testMatrixMultMatrixMultDigitMinusMatrix() {
//        let first = Matrix<Double>(
//    }

}
