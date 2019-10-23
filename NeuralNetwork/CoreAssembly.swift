//
//  CoreAssembly.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa
import Swinject


class CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ServicesPoolInput.self) { _ in
            return ServicesPool(withResolver: container)
        }
        .inObjectScope(.weak)
    }
}


