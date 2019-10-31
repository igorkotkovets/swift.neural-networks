//
//  Matrix.swift
//  NeuralNetwork
//
//  Created by igork on 6/8/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import os.log

struct Matrix<Element> {
    enum Error: Swift.Error {
        case matrixesAreNotConsistent
    }

    let rows: Int
    let columns: Int
    var array: [Element]
    var count: Int {
         return columns*rows
    }
    let outputLog = OSLog(subsystem: "com.kotkovets.matrix", category: "matrix")

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

    init(rows: Int, columns: Int, elements: Element...) {
        self.rows = rows
        self.columns = columns
        self.array = elements
    }

    static func column(elements: [Element]) -> Matrix {
        return Matrix(rows: elements.count, columns: 1, array: elements)
    }

    static func column(elements: Element...) -> Matrix {
        return Matrix(rows: elements.count, columns: 1, array: elements)
    }

    subscript(row: Int, column: Int) -> Element {
        get {
            return array[row*columns+column]
        }
        set {
            array[row*columns+column] = newValue
        }
    }

    var T: Matrix<Element> {
        return Matrix(rows: columns, columns: rows, array: array)
    }
}

extension Matrix: Sequence {
    __consuming func makeIterator() -> MatrixIterator<Element> {
        return MatrixIterator(matrix: self)
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
        self.array = Array<Element>(unsafeUninitializedCapacity: count) { buffer, initializedCount in
            for x in 0..<count {
                buffer[x] = Double.random(in: random.0...random.1)
            }

            initializedCount = count
        }
    }

    init(rows: Int, columns: Int, valuesInRange: ClosedRange<Double>) {
        self.rows = rows
        self.columns = columns
        let count = rows*columns
        self.array = Array<Element>(unsafeUninitializedCapacity: count) { buffer, initializedCount in
            for x in 0..<count {
                buffer[x] = Double.random(in: valuesInRange)
            }
            initializedCount = count
        }
    }
}

extension Matrix where Element: SignedNumeric {
    static func * (lhs: Matrix, rhs: Element) -> Matrix {
        let mult = lhs.array.map { $0*rhs }
        return Matrix<Element>(rows: lhs.rows, columns: lhs.columns, array: mult)
    }

    func dot(_ rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhs = self
        guard lhs.columns == rhs.rows else {
            throw Matrix.Error.matrixesAreNotConsistent
        }

        var resultArray = Array<Element>()

        for row in 0..<lhs.rows {
            for column in 0..<rhs.columns {
                var value: Element = .zero
                for i in 0..<lhs.columns {
                    value += lhs[row,i]*rhs[i,column]
                }
                resultArray.append(value)
            }
        }
        let result = Matrix(rows: lhs.rows, columns: rhs.columns, array: resultArray)
        return result
    }

    func apply(_ function: ((Matrix) -> Matrix)) -> Matrix {
        return function(self)
    }

    static prefix func - (matrix: Matrix) -> Matrix {
        let sub = matrix.array.map { -$0 }
        return Matrix(rows: matrix.rows, columns: matrix.columns, array: sub)
    }

    static func - (lhs: Matrix, rhs: Matrix) -> Matrix {
        let resArray = zip(lhs, rhs).map{ $0-$1 }
        return Matrix(rows: lhs.rows, columns: lhs.columns, array: resArray)
    }

    static func + (lhs: Element, rhs: Matrix) -> Matrix {
        let result = rhs.array.map { lhs + $0}
        return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
    }

    static func * (lhs: Element, rhs: Matrix) -> Matrix {
        let result = rhs.array.map { lhs * $0 }
        return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
    }

    static func - (lhs: Element, rhs: Matrix) -> Matrix {
        let result = rhs.array.map { lhs - $0 }
        return Matrix(rows: rhs.rows, columns: rhs.columns, array: result)
    }

    static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        let resArray = zip(lhs, rhs).map{ $0*$1 }
        return Matrix(rows: lhs.rows, columns: lhs.columns, array: resArray)
    }

    static func += (lhs: Matrix, rhs: Matrix) -> Matrix {
        let resArray = zip(lhs, rhs).map{ $0+$1 }
        return Matrix(rows: lhs.rows, columns: lhs.columns, array: resArray)
    }

    static func + (lhs: Matrix, rhs: Matrix) -> Matrix {
        let resArray = zip(lhs, rhs).map{ $0+$1 }
        return Matrix(rows: lhs.rows, columns: lhs.columns, array: resArray)
    }
}

func / (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    let result = rhs.array.map { lhs / $0 }
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
