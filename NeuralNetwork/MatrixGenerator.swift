//
//  MatrixGenerator.swift
//  NeuralNetwork
//
//  Created by igork on 6/9/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

struct MatrixGenerator<T>: IteratorProtocol {
    var index: Int = 0
    var matrix: Matrix<T>

    init(matrix: Matrix<T>) {
        self.matrix = matrix
    }

    mutating func next() -> T? {
        if index >= matrix.columns*matrix.rows {
            return nil
        }
        else {
            let position = positionAtIndex(index)
            defer { index += 1 }
            return matrix[position.0, position.1]
        }
    }

    func positionAtIndex(_ index: Int) -> (Int, Int) {
        let row = index % matrix.rows
        let column = index / matrix.rows
        return (row, column)
    }
}
