//
//  AppDelegate.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/20/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa
import Swinject

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let diResolver = {
        Assembler([CoreAssembly(), MainScreenAssembly()]).resolver
    }()
    let mainWindowController = MainWindowController()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindowController.showWindow(nil)
        mainWindowController.contentViewController = diResolver.resolve(MainViewInput.self)?.viewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


