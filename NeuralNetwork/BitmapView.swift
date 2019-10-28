//
//  BitmapView.swift
//  NeuralNetwork
//
//  Created by Igor Kotkovets on 10/26/19.
//  Copyright © 2019 Igor Kotkovets. All rights reserved.
//

import Cocoa
import RxCocoa
import RxSwift



class BitmapView: NSView {
    struct Cell {
        let color: CGColor
        let rect: NSRect
    }

    struct Line {
        let p0: CGPoint
        let p1: CGPoint
    }

    private var matrix: Matrix<CGFloat>? = nil
    var cells: [Cell] = []
    var verticalLines: [Line] = []
    var horizontalLines: [Line] = []
    private(set) var viewModel: BitmapViewModel?
    let disposeBag = DisposeBag()
    @IBOutlet private var prevButton: NSButton!
    @IBOutlet private var nextButton: NSButton!
    @IBOutlet private var indexLabel: NSTextField!
    @IBOutlet private var pixelsView: NSView!

    override var wantsDefaultClipping: Bool {
        return false
    }

    func accept(_ viewModel: BitmapViewModel) {
        self.viewModel = viewModel
        viewModel.bindObservableToNext(nextButton.rx.tap.asObservable(), disposeBag: disposeBag)
        viewModel.bindObservableToPrev(prevButton.rx.tap.asObservable(), disposeBag: disposeBag)
        viewModel.bitmapMetadataObservable
        .do(onNext: { [weak self] in
            if let matrix = $0?.matrix {
                self?.drawMatrix(matrix)
            }
            if let value = $0?.value {
                self?.indexLabel.stringValue = String(value)
            } else {
                self?.indexLabel.stringValue = ""
            }
        })
        .subscribe().disposed(by: disposeBag)
    }

    func drawMatrix(_ matrix: Matrix<CGFloat>) {
        self.matrix = matrix
        clearPixelView()
        preparePixelViewsFor(matrix)
        setNeedsDisplay(bounds)
    }

    func clearPixelView() {
        cells.removeAll()
        verticalLines.removeAll()
        horizontalLines.removeAll()
    }

    func preparePixelViewsFor(_ matrix: Matrix<CGFloat>) {
        guard let matrix = self.matrix else {
            return
        }

        let startX = pixelsView.frame.minX
        let drawWidth = pixelsView.frame.width
        let startY = pixelsView.frame.minY
        let endY = pixelsView.frame.maxY
        let drawHeight = pixelsView.frame.height
        let endX = pixelsView.frame.maxY
        let columns = matrix.columns

        for column in 0...columns {
            let x = startX+CGFloat(column)*drawWidth/CGFloat(matrix.columns)
            let line = Line(p0: CGPoint(x:x, y:startY), p1: CGPoint(x: x, y: endY))
            verticalLines.append(line)
        }

        for row in 0...matrix.rows {
            let y = endY-CGFloat(row)*drawHeight/CGFloat(matrix.rows)
            let line = Line(p0: CGPoint(x:startX, y:y), p1: CGPoint(x:endX, y:y))
            horizontalLines.append(line)
        }

        for row in 0..<matrix.rows {
            for column in 0..<columns {
                let value = matrix[row,column]
                let color = NSColor(calibratedRed: value, green: value, blue: value, alpha: 1.0)
                let width = drawWidth/CGFloat(matrix.columns)
                let height = drawHeight/CGFloat(matrix.rows)
                let xLeft = startX+CGFloat(column)*width
                let yBottom = endY-CGFloat(row+1)*height
                let rect = NSRect(x: xLeft, y: yBottom, width: width, height: height)
                let cell = Cell(color: color.cgColor, rect: rect)
                cells.append(cell)
            }
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if let ctx = NSGraphicsContext.current?.cgContext {

            let scaleFactor = NSScreen.main?.backingScaleFactor ?? 1.0
            let px1Width = 1.0/scaleFactor
            ctx.setLineWidth(px1Width)
            ctx.setStrokeColor(NSColor.blue.cgColor)
            for line in verticalLines {
                let path = CGMutablePath()
                path.move( to: line.p0)
                path.addLine(to: line.p1)
                path.closeSubpath()
                ctx.addPath(path)
            }
            for line in horizontalLines {
                let path = CGMutablePath()
                path.move( to: line.p0)
                path.addLine(to: line.p1)
                path.closeSubpath()
                ctx.addPath(path)
            }
            ctx.drawPath(using: .stroke)

            for cell in cells {
                let path = CGMutablePath()
                path.addRect(cell.rect)
                path.closeSubpath()
                ctx.addPath(path)
                ctx.setFillColor(cell.color)
                ctx.drawPath(using: .fill)
            }
        }
    }
}
