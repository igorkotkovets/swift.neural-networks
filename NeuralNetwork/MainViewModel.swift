//
//  MainViewModel.swift
//  NeuralNetwork
//
//  Created by igork on 10/23/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class MainViewModel {
    var testBitmapViewModel: BitmapViewModel!
    var trainBitmapViewModel: BitmapViewModel!
    private var neuralNetwork: NeuralNetworkInput?
    private var trainDataset = [CharacterMetadata]()
    private var testDataset = [CharacterMetadata]()
    private let inputNodes = 784
    private let hiddenNodes = 100
    private let outputNodes = 10
    private let learningRate = 0.3
    private var recognizeListValue = BehaviorRelay<[Double]>(value: [])
    var recognizedListObservable: Observable<[Double]> { return recognizeListValue.asObservable() }

    init(trainViewModel: BitmapViewModel, testViewModel: BitmapViewModel) {
        self.trainBitmapViewModel = trainViewModel
        self.testBitmapViewModel = testViewModel;
    }

    func openDatasetFileAtURL(_ url: URL) -> Observable<[CharacterMetadata]> {
        return Observable.create { observer in
            guard let fileReader = try? FileReader(fileURL: url) else {
                observer.onCompleted()
                return Disposables.create()
            }

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

            observer.onNext(allSymbols)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func bindObservableToTrainNeuralNetwork(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable
            .do(onNext: { [unowned self] in
                self.neuralNetwork = NeuralNetwork(inputNodes: self.inputNodes,
                                                   hiddenNodes: self.hiddenNodes,
                                                   outputNodes: self.outputNodes,
                                                   learningRate: self.learningRate)
            })
            .do(onNext: { [unowned self] in
                for character in self.trainDataset {
                    var targets = Array<Double>(repeating: 0.01, count: self.outputNodes);
                    targets[character.value] = 0.99
                    let inputs = character.matrix.array
                    try? self.neuralNetwork?.train(inputs: inputs, targets: targets)
                }
            })
            .subscribe().disposed(by: disposeBag)
    }

    func bindObservableToLoadTrainFileAtURL(_ observable: Observable<URL?>, disposeBag: DisposeBag) {
        observable.filter { $0 != nil}
            .flatMap { return self.openDatasetFileAtURL($0!) }
            .do(onNext: { [unowned self] dataset in
                self.trainDataset = dataset
                self.trainBitmapViewModel?.acceptBitmaps(dataset)
            })
            .subscribe().disposed(by: disposeBag)
    }

    func bindObservableToLoadTestFileAtURL(_ observable: Observable<URL?>, disposeBag: DisposeBag) {
        observable.filter { $0 != nil}
            .flatMap { return self.openDatasetFileAtURL($0!) }
            .do(onNext: { [unowned self] dataset in
                self.testDataset = dataset
                self.testBitmapViewModel?.acceptBitmaps(dataset)
            })
            .subscribe().disposed(by: disposeBag)
    }

    func bindObservableToRecognizeCharacter(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable
            .flatMap { _ in
                return self.testBitmapViewModel.characterObservable
        }
    .do(onNext: { [weak self] characterOrNil in
        guard let character = characterOrNil,
        let result = try? self?.neuralNetwork?.query(inputs: character.matrix.array) else {
            return
        }

        self?.recognizeListValue.accept(result.array)
    })
    .subscribe().disposed(by: disposeBag)


    }
}
