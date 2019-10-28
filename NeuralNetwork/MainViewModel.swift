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

    init(bitmapViewModel: BitmapViewModel) {
        self.bitmapViewModel = bitmapViewModel
    }

    func openFileURL(_ url: URL) {
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

            bitmapViewModel?.acceptBitmaps(allSymbols)
        }
    }

    func bindObservableToReadTrainFile(_ observable: Observable<Void>) {

    }

    func bindObservableToTrainNetwork(_ observable: Observable<Void>) {

    }
}
