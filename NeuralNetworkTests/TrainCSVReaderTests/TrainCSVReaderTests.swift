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
        XCTAssertNoThrow(try FileReader(filePath: existingPath!), "throwing")
    }

    func testCreateFileReaderForNotExistingFile() {
        var wrongPath = bundle.path(forResource: "EmptyFile", ofType: "csv")
        wrongPath?.append("2")
        XCTAssertNotNil(wrongPath, "Nil")
        XCTAssertThrowsError(try FileReader(filePath: wrongPath!))
    }

    func testFileReaderReads3Lines() {
        let filePath = bundle.path(forResource: "3Lines", ofType: "csv")
        XCTAssertNotNil(filePath)
        let reader = try? FileReader(filePath: filePath!)
        XCTAssertNotNil(reader)
        let firstLine = reader?.readLine(strippingNewline: false)
        XCTAssertNotNil(firstLine)
        XCTAssertEqual(firstLine, "aaa\n")
        let secondLine = reader?.readLine(strippingNewline: false)
        XCTAssertNotNil(secondLine)
        XCTAssertEqual(secondLine, "bbb\n")
        let thirdLine = reader?.readLine(strippingNewline: false)
        XCTAssertNotNil(thirdLine)
        XCTAssertEqual(thirdLine, "ccc\n")
        let nilFourth = reader?.readLine(strippingNewline: false)
        XCTAssertNil(nilFourth)
    }

    func testReadTrainingCSV() {
        let filePath = bundle.path(forResource: "mnist_train_100", ofType: "csv")
        XCTAssertNotNil(filePath)
        let reader = try? FileReader(filePath: filePath!)
        XCTAssertNotNil(reader)
        var strLine: String?
        var count: Int = 0
        repeat {
            strLine = reader?.readLine()
            if strLine != nil {
                count += 1
            }
        } while strLine != nil
        XCTAssertEqual(count, 100)
    }

    func testRead3EmptyLines() {
        let filePath = bundle.path(forResource: "3EmptyLines", ofType: "cvs")
        XCTAssertNotNil(filePath)
        let reader = try? FileReader(filePath: filePath!)
        XCTAssertNotNil(reader)
        var strLine = reader?.readLine(strippingNewline: false)
        XCTAssertEqual(strLine, "\n")
        strLine = reader?.readLine(strippingNewline: false)
        XCTAssertEqual(strLine, "\n")
        strLine = reader?.readLine(strippingNewline: false)
        XCTAssertEqual(strLine, "\n")
        strLine = reader?.readLine(strippingNewline: false)
        XCTAssertNil(strLine)
    }

    func testReaderStrippingNewLine() {
        let filePath = bundle.path(forResource: "3EmptyLines", ofType: "cvs")
        XCTAssertNotNil(filePath)
        let reader = try? FileReader(filePath: filePath!)
        XCTAssertNotNil(reader)
        var strLine = reader?.readLine()
        XCTAssertEqual(strLine, "")
        strLine = reader?.readLine()
        XCTAssertEqual(strLine, "")
        strLine = reader?.readLine()
        XCTAssertEqual(strLine, "")
        strLine = reader?.readLine()
        XCTAssertNil(strLine)
    }
}
