//
//  TrainCSVReader.swift
//  NeuralNetwork
//
//  Created by igork on 10/23/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation

protocol FileStreamInput {
    func readLine() -> String?
}

class FileStream: FileStreamInput {
    enum Error: Swift.Error {
        case unableToOpenFile
    }

    let fileHandle: FileHandle
    var eofReached: Bool = false
    let newLineCharacter = 10
    let bufferSize: Int
    var buffer = Data()
    let encoding = String.Encoding.utf8

    init?(filePath: String, bufferSize: Int = 1024) throws {
        guard let fileHandle = FileHandle(forReadingAtPath: filePath) else {
            throw Error.unableToOpenFile
        }
        self.fileHandle = fileHandle
        self.bufferSize = bufferSize
    }

    func readLine() -> String? {
        var result: String? = nil
        var newLinePosition = -1

        repeat {
            var str: String?
            let readData = fileHandle.readData(ofLength: bufferSize)
            let readLen = readData.count
            buffer.append(readData)
            self.eofReached = (readLen != bufferSize)

            for (i, char) in buffer.enumerated() {
                if char == 10 {
                    newLinePosition = i
                    break
                }
            }

            if (newLinePosition<0) {
                if (buffer.count > 0) {
                    str = String(data: buffer, encoding: encoding)
                }
                buffer.removeAll()
            } else {
                str = String(data: buffer[buffer.startIndex...buffer.startIndex+newLinePosition], encoding: encoding)
                buffer = buffer.suffix(buffer.count-newLinePosition-1)
            }

            if result == nil {
                result = str
            } else if str != nil {
                result?.append(str!)
            }
        } while self.eofReached == false && newLinePosition < 0

        return result
    }
}

