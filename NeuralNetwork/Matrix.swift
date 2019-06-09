//
//  Matrix.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

struct Matrix<Element> {
    let rows: Int
    let columns: Int
    var array: [Element]
    var count: Int {
         return columns*rows
    }

    init(rows: Int, columns: Int, defaultValue: Element) {
        self.rows = rows
        self.columns = columns
        array = Array(repeating: defaultValue, count: rows*columns)
    }

    init(rows: Int, columns: Int, array: [Element]) {
        self.rows = rows
        self.columns = columns
        self.array = array
    }

    subscript(row: Int, column: Int) -> Element {
        get {
            return array[row*columns+column]
        }
        set {
            array[row*columns+column] = newValue
        }
    }

    func transformed() -> Matrix<Element> {
        return Matrix(rows: columns, columns: rows, array: array)
    }
}

extension Matrix: Sequence {
    __consuming func makeIterator() -> MatrixGenerator<Element> {
        return MatrixGenerator(matrix: self)
    }
}

extension Matrix: CustomDebugStringConvertible {
    var debugDescription: String {
        var string = "["
        for i in 0..<rows {
            string.append("[")
            for j in 0..<columns {
                string.append("\(self[i,j])")
                if j != columns-1 {
                    string.append(", ")
                }
            }
            string.append("]")
            if i != rows-1 {
                string.append(",\n")
            }
        }
        string.append("]")
        return string
    }
}

extension Matrix where Element == Double {
    init(rows: Int, columns: Int, random: (Double, Double)) {
        self.rows = rows
        self.columns = columns
        let count = rows*columns
        self.array = Array<Element>(_unsafeUninitializedCapacity: count) { buffer, initializedCount in
            for x in 0..<count {
                buffer[x] = Double.random(in: random.0...random.1)
            }

            initializedCount = count
        }
    }

    func mult(_ value: Double) -> Matrix {
        let mult = array.map { $0*value }
        return Matrix<Element>(rows: rows, columns: columns, array: mult)
    }

    static func * (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
        var result = Matrix(rows: lhs.rows, columns: lhs.columns, defaultValue: 0)
        for i in 0..<lhs.rows {
            for j in 0..<lhs.columns {
                var value = 0.0
                for t in 0..<lhs.columns {
                    value += lhs[i,t]*rhs[t,j]
                }
                result[i,j] = value
            }
        }
        return result
    }
}

prefix func - (matrix: Matrix<Double>) -> Matrix<Double> {
    let sub = matrix.array.map { -$0 }
    return Matrix(rows: matrix.rows, columns: matrix.columns, array: sub)
}

func + (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    let result = rhs.array.map { lhs + $0}
    return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
}

func / (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    let result = rhs.array.map { lhs / $0 }
    return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
}

func * (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    let result = rhs.array.map { lhs * $0 }
    return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
}

func sigmoid(_ z: Matrix<Double>) -> Matrix<Double> {
    return 1.0 / (1.0 + exp(-z))
}

func exp(_ value: Matrix<Double>) -> Matrix<Double> {
    let result = value.array.map { exp($0) }
    return Matrix(rows: value.rows, columns: value.columns, array: result)
}

func exp(value: [Double]) -> [Double] {
    return value.map { exp($0) }
}
