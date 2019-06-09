//
//  MatrixGeneratorTests.swift
//  NeuralNetworkTests
//
//  Created by igork on 6/9/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest

class MatrixGeneratorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatReturnsCorrectPosition() {
        let matrix = Matrix(rows: 3, columns: 3, defaultValue: 0)
        let generator = MatrixGenerator(matrix: matrix)
        let position0_0 = generator.positionAtIndex(1)
        XCTAssertEqual(position0_0.0, 0)
        XCTAssertEqual(position0_0.1, 1)

        let position2_2 = generator.positionAtIndex(8)
        XCTAssertEqual(position2_2.0, 2)
        XCTAssertEqual(position2_2.1, 2)

        let position1_0 = generator.positionAtIndex(3)
        XCTAssertEqual(position1_0.0, 1)
        XCTAssertEqual(position1_0.1, 0)

        let position0_2 = generator.positionAtIndex(2)
        XCTAssertEqual(position0_2.0, 0)
        XCTAssertEqual(position0_2.1, 2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
