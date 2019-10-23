//
//  MainScreenAssemblyAssembly.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/22/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Swinject
import Foundation

class MainScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainViewInput.self) { resolver in
//            let windowController = MainWindowController()
            let viewController = MainViewController()
//            windowController.contentViewController = viewController
            return viewController
        }
    }
}
