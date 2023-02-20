//
//  ShiftedLinePart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/20.
//

import Foundation

class ShiftedLinePart: ExecutableResult {
    
    var reader: NomoReader
    var shiftedLines: [LinedObject]?
    var title: String
    
    func execute(_ outer: Double, _ inner: Double) -> Result<Double, NomogramError> {
        // OUTER - АРГУМЕНТ ПРИХОДЯЩИЙ ИЗ ПРЕДЫДУЩЕГО ГРАФИКА
        // INNER - АРГУМЕНТ СБОКУ
        guard shiftedLines != nil else { return .failure(.interpolateError("Ошибка чтения \(title)")) }
        shiftedLines = shiftedLines!.sorted(by: {$0.in > $1.in})
        let count = shiftedLines!.count
        
        if outer > shiftedLines![0].in {
            return .failure(.outOfLimits("Аргумент выше лимита \(title)"))
        }
        for index in 0...count-1 {
            if outer > shiftedLines![index].in {
                let nextIndex = (index>0) ? index-1 : index
                let res = Interpolator.flatInterpolate(argument: outer, from: (shiftedLines![index].in, shiftedLines![nextIndex].in), to: (shiftedLines![index].out, shiftedLines![nextIndex].out))
                return .success(res)
            }
        }
        return .failure(.outOfLimits("Аргумент ниже лимита \(title)"))
    }
    
    init(fileName: String) {
        self.reader = NomoReader(file: fileName)
        self.title = fileName
        
        if let shiftedLines = reader.dataToShiftedLineNomogram() {
            self.shiftedLines = shiftedLines
        }
    }
    
}
