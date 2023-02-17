//
//  PolyNomogramPart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

class PolyNomogramPart: Executable {
    
    var lines: [MyLine]?
    let reader: NomoReader?
    
    init(fileName: String) {
        self.reader = NomoReader(file: fileName)
        if let elevationNomogram = self.reader!.dataToPolyNomogram() {
            self.lines = elevationNomogram.sorted(by: {$0.outer > $1.outer})
        }
    }
    
    func findNeigbours(argument: Double) -> [Double]? {
        guard self.lines != nil else { return nil }
        let bigger = self.lines!.first?.outer
        let smaller = self.lines!.last?.outer
        
        if let smaller = smaller, let bigger = bigger, smaller...bigger ~= argument {
            let total = bigger - smaller
            let step = Double(total)/Double((self.lines!.count - 1))
            let upper = floor(argument/step)*step
            let lower = ceil(argument/step)*step
            return [upper, lower]
        } else {
            return nil
        }
    }
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        
        let limits = findNeigbours(argument: inner)
        var segm = Array(repeating: [0.0], count: 2)
        guard limits != nil else { return nil }
        print(limits)
        if let lines = self.lines {
            for i in 0...1 {
                for line in lines {
                    if limits![i] == line.outer {
                        for segment in line.segments {
                            let range = segment[0][1]...segment[1][1]
                            if range ~= outer {
                                let value = Interpolator.interpolate3D(argument: outer, pairs: segment)
                                segm[i] = [value, limits![i]]
                            }
                        }
                    }
                }
            }
           print(segm)
           return Interpolator.interpolate3D(argument: inner, pairs: segm)
        }
        return nil
    }
}
