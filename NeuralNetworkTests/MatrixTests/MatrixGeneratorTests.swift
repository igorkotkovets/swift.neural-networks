//
//  MatrixGeneratorTests.swift
//  NeuralNetworkTests
//
//  Created by Igor Kotkovets on 10/29/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixGeneratorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testMatrixGeneratorEnumerating() {
        let matrix = Matrix(rows: 1, columns: 4, array: [0,1,2,3])
        var iterator = MatrixGenerator(matrix: matrix)

        var value = iterator.next()
        XCTAssertEqual(0, value!)
        value = iterator.next()
        XCTAssertEqual(1, value!)
        value = iterator.next()
        XCTAssertEqual(2, value!)
        value = iterator.next()
        XCTAssertEqual(3, value!)
        value = iterator.next()
        XCTAssertNil(value)
    }

    func testPositionFromIndex() {
        let matrix = Matrix(rows: 1, columns: 4, array: [0,1,2,3])
        let iterator = MatrixGenerator(matrix: matrix)
        var position = iterator.positionAtIndex(0)
        XCTAssertEqual(position.0, 0)
        XCTAssertEqual(position.1, 0)
        position = iterator.positionAtIndex(1)
        XCTAssertEqual(position.0, 0)
        XCTAssertEqual(position.1, 1)
    }

}
