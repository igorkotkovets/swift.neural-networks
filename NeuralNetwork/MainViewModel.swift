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
                let inputNodes = 3
                let hiddenNodes = 3
                let outputNodes = 3
                let learningRate = 0.3

                self.neuralNetwork = NeuralNetwork(inputNodes: inputNodes,
                                                   hiddenNodes: hiddenNodes,
                                                   outputNodes: outputNodes,
                                                   learningRate: learningRate)
                let result = try? self.neuralNetwork?.query(inputs: 1.0, 0.5, -1.5)
            })
            .subscribe().disposed(by: disposeBag)


    }

    func bindObservableToReadTrainFile(_ observable: Observable<Void>) {
        if trainDataset.count > 0 {

        }
    }

    func bindObservableToTrainNetwork(_ observable: Observable<Void>) {

    }
}
