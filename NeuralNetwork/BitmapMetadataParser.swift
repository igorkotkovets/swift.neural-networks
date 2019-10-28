//
//  BitmapMetadataParser.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/25/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation


let defaultNormalizationFunction: (Int) -> CGFloat = { x in
    return CGFloat(x)/255.0*0.99+0.01
}

struct BitmapMetadataParser {
    let totalElementsCount: Int = 785
    let bitmapElementsCount: Int = 784
    let rows = 28
    let columns = 28
    let normalizationFunction: (Int) -> CGFloat

    init(normalizationFunction: @escaping ((Int) -> CGFloat) = defaultNormalizationFunction) {
        self.normalizationFunction = normalizationFunction
    }


    func parse(_ str: String) -> BitmapMetadata? {
        let strComponents = str.components(separatedBy: ",")
        let ints = strComponents.compactMap({ Int($0) })

        guard ints.count == totalElementsCount else {
            return nil
        }

        let value = ints[0]
        let bitmap = ints[1...].compactMap(self.normalizationFunction)

        guard bitmap.count == bitmapElementsCount else {
            return nil
        }

        let matrix: Matrix<CGFloat> = Matrix(rows: 28, columns: 28, array: Array(bitmap))
        let metadata = BitmapMetadata(value: value, matrix: matrix)
        return metadata
    }
}
