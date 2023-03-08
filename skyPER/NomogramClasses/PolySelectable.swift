//
//  PolyNomogramPart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

class PolySelectable: Executable {
    
    var lines: [MyLine]?
    let reader: NomoReader?
    
    init(fileName: String) {
        self.reader = NomoReader(file: fileName)
        if let elevationNomogram = self.reader!.dataToPolyNomogram() {
            self.lines = elevationNomogram.sorted(by: {$0.outer > $1.outer})
        }
    }
    
    func findNearestBaseLineDiff(argument: Double) -> (MyLine?, Double)? {
        guard self.lines != nil else { return nil }
        var minDiff = Double.greatestFiniteMagnitude
        var nearest: MyLine?
        for line in self.lines! {
            let diff = argument - line.outer
            if abs(diff) < abs(minDiff) {
                minDiff = diff
                nearest = line
            }
        }
        return (nearest, minDiff)
    }
    
    
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        //OUTER-left value, INNER-right value
        if let (nearestLine, diff) = findNearestBaseLineDiff(argument: outer) {
            if let line = nearestLine {
                for segment in line.segments {
                    let correctedInner = inner - diff
                    if segmentContains(argument: correctedInner, segment: segment, argumentNumber: 0) {
                        let weight = Interpolator.flatInterpolate(argument: correctedInner, from: (segment[0][0],segment[1][0]), to: (segment[0][1],segment[1][1]))
                        return weight
                    }
                }
            }
            
        }
        return nil
    }
}
