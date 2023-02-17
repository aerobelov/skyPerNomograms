//
//  ShiftedLinePart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/20.
//

import Foundation

class ShiftedLinePart: Executable {
    
    var reader: NomoReader
    var shiftedLines: [LinedObject]?
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        guard shiftedLines != nil else { return nil }
        shiftedLines = shiftedLines!.sorted(by: {$0.weight > $1.weight})
        var k = 0.0
        let count = shiftedLines!.count
        
        for index in 0...count-1 {
            if outer > shiftedLines![index].weight {
                let nextIndex = (index>0) ? index-1 : index
                k = Interpolator.flatInterpolate(argument: outer, from: (shiftedLines![index].weight, shiftedLines![nextIndex].weight), to: (shiftedLines![index].koef, shiftedLines![nextIndex].koef))
                return outer-k
            }
        }
        return nil
    }
    
    init(fileName: String) {
        self.reader = NomoReader(file: fileName)
        if let shiftedLines = reader.dataToShiftedLineNomogram() {
            self.shiftedLines = shiftedLines
        }
    }
    
}
