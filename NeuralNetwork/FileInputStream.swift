//
//  FileInputStream.swift
//  Pods
//
//  Created by Igor Kotkovets on 11/3/17.
//

import Foundation

public class FileInputStream: Stream {
    let fileHandle: FileHandle
    var eofReached = false

    public init(withFileHandle: FileHandle) {
        self.fileHandle = withFileHandle
//        super.init()
    }

    public convenience init?(withPath path: String) {
        guard let fHandle = FileHandle(forReadingAtPath: path) else {
            return nil
        }
        self.init(withFileHandle: fHandle)
    }

    public convenience init(withUrl url: URL) throws {
        let fHandle = try FileHandle(forReadingFrom: url)
        self.init(withFileHandle: fHandle)
    }

    public var hasBytesAvailable: Bool {
        return !eofReached
    }

    public func  read(_ buffer: UnsafeMutablePointer<UInt8>, maxLength len: Int) -> Int {
        let readData = fileHandle.readData(ofLength: len)
        eofReached = (readData.count != len)
        readData.withUnsafeBytes { (ptr: UnsafePointer<UInt8>) in
            buffer.initialize(from: ptr, count: readData.count)
        }

        return readData.count
    }
}
