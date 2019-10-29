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
    var bitmapView: BitmapView?
    var viewModel: MainViewModel!
    @IBOutlet private var bitmapViewContainer: NSView!
    @IBOutlet private var resetNeuralNetworkButton: NSButton!
    @IBOutlet private var trainNetworkButton: NSButton!
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
        addBitmapView()
        bindControlsWithViewModel()
    }

    fileprivate func addBitmapView() {
        if let viewNib = NSNib(nibNamed: "BitmapView", bundle: nil),
            let bitmapView: BitmapView = viewNib.instantiate(withOwner: nil) {
            self.bitmapView = bitmapView
            bitmapView.translatesAutoresizingMaskIntoConstraints = false
            self.bitmapViewContainer.addSubview(bitmapView)
            bitmapView.leadingAnchor.constraint(equalTo: bitmapViewContainer.leadingAnchor).isActive = true
            bitmapView.trailingAnchor.constraint(equalTo: bitmapViewContainer.trailingAnchor).isActive = true
            bitmapView.topAnchor.constraint(equalTo: bitmapViewContainer.topAnchor).isActive = true
            bitmapView.bottomAnchor.constraint(equalTo: bitmapViewContainer.bottomAnchor).isActive = true

            bitmapView.accept(viewModel.bitmapViewModel!)
        }
    }

    func bindControlsWithViewModel() {
        viewModel
            .bindObservableToResetNeuralNetwork(resetNeuralNetworkButton.rx.tap.asObservable(),
                                                disposeBag: disposeBag)
        viewModel
            .bindObservableToTrainNetwork(trainNetworkButton.rx.tap.asObservable(),
                                          disposeBag: disposeBag)
    }

    @IBAction func showBitmapView(_ sender: NSButton) {
        //        let array = Array(repeating: 3, count: 100)
        //        let matrix = Matrix(rows: 10, columns: 10, array: array);
        //        self.bitmapView?.drawMatrix(matrix)
    }

    @IBAction func didTapResetNeuralNetwork(_ sender: NSButton) {
        
    }

    @IBAction func loadTrainingFile(_ sender: NSButton) {
        showPanelAndSelecFile()
    }

    func showPanelAndSelecFile() {
        guard let window = view.window else { return }

        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false

        panel.beginSheetModal(for: window) { (result) in
            if result == NSApplication.ModalResponse.OK {
                let selectedFile = panel.urls[0]
                self.viewModel.openTrainFileAtURL(selectedFile)
            }
        }
    }
    
}
