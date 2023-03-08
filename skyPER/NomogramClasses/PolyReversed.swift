//
//  PolyNomogramPart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

class PolyReversed: Executable {
    
    var lines: [MyLine]?
    let reader: NomoReader?
    
    init(fileName: String) {
        self.reader = NomoReader(file: fileName)
        if let elevationNomogram = self.reader!.dataToPolyNomogram() {
            self.lines = elevationNomogram.sorted(by: {$0.outer > $1.outer})
        }
    }
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        //OUTER-bottom value, INNER-right value
        if let lines = self.lines,
           var minimumDiff = lines.first?.outer {
            var nearest = 0.0
            for line in lines {
                for segment in line.segments {
                    if segmentContains(argument: outer, segment: segment, argumentNumber: 1) {
                        let d = Interpolator.flatInterpolate(argument: outer, from: (segment[0][1], segment[1][1]), to: (segment[0][0], segment[1][0]))
                        let delta = inner - d
                        if abs(delta) < abs(minimumDiff) {
                            minimumDiff = delta
                            nearest = line.outer
                        }
                    }
                }
            }
            return nearest + minimumDiff
        }
        return nil
    }
    
}
