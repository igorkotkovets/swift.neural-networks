//
//  BitmapViewModel.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/26/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BitmapViewModel {
    private var currentIndex = 0
    private var bitmapMetadataVariable = BehaviorRelay<CharacterMetadata?>(value: nil)
    var bitmapMetadataObservable: Observable<CharacterMetadata?> { return bitmapMetadataVariable.asObservable() }
    private var bitmaps: [CharacterMetadata]?
    private var valueVariable = BehaviorRelay<Int?>(value: nil)
    private var valueObservable: Observable<String> {
        return valueVariable
            .map {
                if let value = $0 {
                    return String(value)
                } else {
                    return ""
                }
        }.asObservable()
    }

    init() {

    }

    func bindObservableToNext(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable.do(onNext: { [unowned self] in
            self.currentIndex = self.currentIndex + 1
            if self.currentIndex >= self.bitmaps?.count ?? 0 {
                self.currentIndex = 0
                self.bitmapMetadataVariable.accept(self.bitmaps?.first)
            } else {
                self.bitmapMetadataVariable.accept(self.bitmaps?[self.currentIndex])
            }

        })
            .subscribe().disposed(by: disposeBag)
    }

    func bindObservableToPrev(_ observable: Observable<Void>, disposeBag: DisposeBag) {
        observable.do(onNext: { [unowned self] in
            self.currentIndex = self.currentIndex - 1
            let count = self.bitmaps?.count ?? 0
            if self.currentIndex < 0 {
                if count > 0 {
                    self.currentIndex = count - 1
                    self.bitmapMetadataVariable.accept(self.bitmaps?.last)
                } else {
                    self.currentIndex = 0
                    self.bitmapMetadataVariable.accept(self.bitmaps?.first)
                }
            } else {
                self.bitmapMetadataVariable.accept(self.bitmaps?[self.currentIndex])
            }
        })
            .subscribe().disposed(by: disposeBag)
    }

    func acceptBitmaps(_ list: [CharacterMetadata]) {
        bitmaps = list
        self.currentIndex = 0
        bitmapMetadataVariable.accept(list.first)
    }
}
