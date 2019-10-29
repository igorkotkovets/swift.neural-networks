//
//  MainViewModel.swift
//  NeuralNetwork
//
//  Created by igork on 10/23/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import RxSwift


class MainViewModel {
    var bitmapViewModel: BitmapViewModel?
    private var neuralNetwork: NeuralNetworkInput?
    private var trainDataset = [CharacterMetadata]()
    private let inputNodes = 784
    private let hiddenNodes = 100
    private let outputNodes = 10
    private let learningRate = 0.3

    init(bitmapViewModel: BitmapViewModel) {
        self.bitmapViewModel = bitmapViewModel
    }

    func openTrainFileAtURL(_ url: URL) {
        if let fileReader = try? FileReader(fileURL: url) {
            let parser = CharactersParser()
            var allSymbols = [CharacterMetadata]()
            var str: String? = nil
            repeat {
                str = fileReader.readLine()
                if let string = str,
                    let bitmap = parser.parse(string) {
                    allSymbols.append(bitmap)
                }
            } while str != nil

            trainDataset = allSymbols
            bitmapViewModel?.acceptBitmaps(allSymbols)
        }
    }

    func bindObservableToResetNeuralNetwork(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable
            .do(onNext: { [unowned self] in
                self.neuralNetwork = NeuralNetwork(inputNodes: self.inputNodes,
                                                   hiddenNodes: self.hiddenNodes,
                                                   outputNodes: self.outputNodes,
                                                   learningRate: self.learningRate)
            })
            .subscribe().disposed(by: disposeBag)


    }

    func bindObservableToReadTrainFile(_ observable: Observable<Void>) {
        if trainDataset.count > 0 {

        }
    }

    func bindObservableToTrainNetwork(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable
        .do(onNext: { [unowned self] in
            for character in self.trainDataset {
                var targets = Array<Double>(repeating: 0.01, count: self.outputNodes);
                targets[character.value] = 0.99
                try? self.neuralNetwork?.train(inputs: character.matrix.array, targets: targets)
            }
        })
        .subscribe().disposed(by: disposeBag)
    }
}
