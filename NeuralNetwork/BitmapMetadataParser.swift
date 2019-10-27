//
//  BitmapMetadataParser.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/25/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

protocol BitmapMetadataParserInput {

}

struct BitmapMetadataParser {
    let totalElementsCount: Int = 785
    let bitmapElementsCount: Int = 784
    let rows = 28
    let columns = 28


    func parse(_ str: String) -> BitmapMetadata? {
        let strComponents = str.components(separatedBy: ",")
        let ints = strComponents.compactMap { Int($0) }

        guard ints.count == totalElementsCount else {
            return nil
        }

        let value = ints[0]
        let bitmap = ints[0...]
        let matrix: Matrix<Int> = Matrix(rows: 28, columns: 28, array: Array(bitmap))
        let metadata = BitmapMetadata(value: value, matrix: matrix)
        return metadata
    }
}
