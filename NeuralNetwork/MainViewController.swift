//
//  MainViewController.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/22/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa
import RxCocoa
import RxSwift

protocol MainViewInput {
    func viewController() -> NSViewController
}

class MainViewController: NSViewController, MainViewInput {
    var servicesPool: ServicesPoolInput?
    var trainBitmapView: BitmapView?
    var testBitmapView: BitmapView?
    var viewModel: MainViewModel!
    @IBOutlet private var trainBitmapViewContainer: NSView!
    @IBOutlet private var testBitmapViewContainer: NSView!
    @IBOutlet private var trainNetworkButton: NSButton!
    @IBOutlet private var loadTestDatasetButton: NSButton!
    @IBOutlet private var loadTrainDatasetButton: NSButton!
    @IBOutlet private var recognizeButton: NSButton!
    @IBOutlet private var recognizedList: NSTextField!
    private let disposeBag = DisposeBag()


    convenience init(servicesPool: ServicesPoolInput?, viewModel: MainViewModel) {
        self.init(nibName: "MainViewController", bundle: nil)
        self.servicesPool = servicesPool
        self.viewModel = viewModel
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

    override func viewDidLoad() {
        super.viewDidLoad()
        addBitmapViews()
        bindControlsWithViewModel()
    }

    fileprivate func addBitmapViews() {
        guard let viewNib = NSNib(nibNamed: "BitmapView", bundle: nil) else {
            return;
        }

        if let bitmapView: BitmapView = viewNib.instantiate(withOwner: nil) {
            self.trainBitmapView = bitmapView
            bitmapView.translatesAutoresizingMaskIntoConstraints = false
            self.trainBitmapViewContainer.addSubview(bitmapView)
            bitmapView.leadingAnchor.constraint(equalTo: trainBitmapViewContainer.leadingAnchor).isActive = true
            bitmapView.trailingAnchor.constraint(equalTo: trainBitmapViewContainer.trailingAnchor).isActive = true
            bitmapView.topAnchor.constraint(equalTo: trainBitmapViewContainer.topAnchor).isActive = true
            bitmapView.bottomAnchor.constraint(equalTo: trainBitmapViewContainer.bottomAnchor).isActive = true
            bitmapView.accept(viewModel.trainBitmapViewModel!)
        }

        if let bitmapView: BitmapView = viewNib.instantiate(withOwner: nil) {
            self.testBitmapView = bitmapView
            bitmapView.translatesAutoresizingMaskIntoConstraints = false
            self.testBitmapViewContainer.addSubview(bitmapView)
            bitmapView.leadingAnchor.constraint(equalTo: testBitmapViewContainer.leadingAnchor).isActive = true
            bitmapView.trailingAnchor.constraint(equalTo: testBitmapViewContainer.trailingAnchor).isActive = true
            bitmapView.topAnchor.constraint(equalTo: testBitmapViewContainer.topAnchor).isActive = true
            bitmapView.bottomAnchor.constraint(equalTo: testBitmapViewContainer.bottomAnchor).isActive = true
            bitmapView.accept(viewModel.testBitmapViewModel!)
        }
    }

    func bindControlsWithViewModel() {
        viewModel
            .bindObservableToTrainNeuralNetwork(trainNetworkButton.rx.tap.asObservable(),
                                                disposeBag: disposeBag)
        let loadTrainFileObservable = loadTrainDatasetButton.rx.tap.asObservable()
            .flatMap {
                return self.showPanelAndSelecFile()
        }
        viewModel.bindObservableToLoadTrainFileAtURL(loadTrainFileObservable, disposeBag: disposeBag)

        let loadTestFileObservable = loadTestDatasetButton.rx.tap.asObservable()
            .flatMap {
                return self.showPanelAndSelecFile()
        }
        viewModel.bindObservableToLoadTestFileAtURL(loadTestFileObservable, disposeBag: disposeBag)
        viewModel.bindNeuralNetworkToRecognizeCharacterFromTestDataset(disposeBag)

        viewModel.recognizedListObservable
            .map {
                var resultStr = ""
                for (index, value) in $0.enumerated() {
                    resultStr.append(String(format: "%d - %0.5f \n", index, value))
                }
                return resultStr
        }
        .bind(to: recognizedList.rx.text).disposed(by: disposeBag)
    }

    @IBAction func showBitmapView(_ sender: NSButton) {
        //        let array = Array(repeating: 3, count: 100)
        //        let matrix = Matrix(rows: 10, columns: 10, array: array);
        //        self.bitmapView?.drawMatrix(matrix)
    }

    @IBAction func loadTrainingFile(_ sender: NSButton) {

    }

    func showPanelAndSelecFile() -> Observable<URL?> {
        return Observable.create { [weak self] observer in
            guard let `self` = self,
                let window = self.view.window else {
                    observer.onCompleted()
                    return Disposables.create()
            }

            let panel = NSOpenPanel()
            panel.canChooseFiles = true
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            panel.beginSheetModal(for: window) { (result) in
                if result == NSApplication.ModalResponse.OK {
                    observer.onNext(panel.urls.first)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
}
