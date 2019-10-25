//
//  TrainCSVReaderTests.swift
//  NeuralNetworkTests
//
//  Created by igork on 10/23/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import XCTest
import Foundation


class TrainCSVReaderTests: XCTestCase {
    lazy var bundle = Bundle(for: TrainCSVReaderTests.self)

    override func setUp() {

    }

    func testCreateFileReaderForExistingFile() {
        let existingPath = bundle.path(forResource: "EmptyFile", ofType: "csv")
        XCTAssertNotNil(existingPath, "Unable to open file")
        XCTAssertNoThrow(try FileStream(filePath: existingPath!), "throwing")
    }

    func testCreateFileReaderForNotExistingFile() {
        var wrongPath = bundle.path(forResource: "EmptyFile", ofType: "csv")
        wrongPath?.append("2")
        XCTAssertNotNil(wrongPath, "Nil")
        XCTAssertThrowsError(try FileStream(filePath: wrongPath!))
    }

    func testFileReaderReads3Lines() {
        var filePath = bundle.path(forResource: "3Lines", ofType: "csv")
        XCTAssertNotNil(filePath)
        let reader = try? FileStream(filePath: filePath!)
        XCTAssertNotNil(reader)
        let firstLine = reader?.readLine()
        XCTAssertNotNil(firstLine)
        XCTAssertEqual(firstLine, "aaa\n")
        let secondLine = reader?.readLine()
        XCTAssertNotNil(secondLine)
        XCTAssertEqual(secondLine, "bbb\n")
        let thirdLine = reader?.readLine()
        XCTAssertNotNil(thirdLine)
        XCTAssertEqual(thirdLine, "ccc\n")
        let nilFourth = reader?.readLine()
        XCTAssertNil(nilFourth)
    }

    func testReadTrainingCSV() {
        let filePath = bundle.path(forResource: "mnist_train_100", ofType: "csv")
        XCTAssertNotNil(filePath)
        let reader = try? FileStream(filePath: filePath!)
        XCTAssertNotNil(reader)
        var strLine: String?
        var count: Int = 0
        repeat {
            strLine = reader?.readLine()

            if strLine != nil {
                print(strLine)
                count += 1
            }
        } while strLine != nil
        XCTAssertEqual(count, 100)
    }
}
