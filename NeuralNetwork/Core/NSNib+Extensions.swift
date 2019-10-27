//
//  NSNib+Extensions.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/27/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa

extension NSNib {
    open func instantiate<T>(withOwner owner: Any?) -> T? {
        var objectsOrNil: NSArray?
        self.instantiate(withOwner: self, topLevelObjects: &objectsOrNil)

        guard let objects = objectsOrNil else {
            return nil
        }

        var result: T?
        for object in objects {
            if let view = object as? T {
                result = view
                break
            }
        }
        return result
    }
}
