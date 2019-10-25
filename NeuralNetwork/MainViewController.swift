//
//  MainViewController.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/22/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa

protocol MainViewInput {
    func viewController() -> NSViewController
}

class MainViewController: NSViewController, MainViewInput {
    var servicesPool: ServicesPoolInput?

    convenience init(servicesPool: ServicesPoolInput?) {
        self.init(nibName: "MainViewController", bundle: nil)
        self.servicesPool = servicesPool
    }

    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewController() -> NSViewController {
        return self
    }

    @IBAction func trainDidTap(_ sender: NSButton) {
        let inputNodes = 3
        let hiddenNodes = 3
        let outputNodes = 3
        let learningRate = 0.3

        let neuralNetwork = NeuralNetwork(inputNodes: inputNodes, hiddenNodes: hiddenNodes, outputNodes: outputNodes, learningRate: learningRate)
        let result = try? neuralNetwork.query(inputs: 1.0, 0.5, -1.5)
        print(result)


    }

    @IBAction func loadResourcesDidTap(_ sender: NSButton) {
        self.servicesPool?.startNeuralNetwork()
        // 1
        guard let window = view.window else { return }

        // 2
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false

        // 3
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSFileHandlingPanelOKButton {
            // 4
            let selectedFolder = panel.urls[0]
            print(selectedFolder)
          }
        }
    }
    
}
