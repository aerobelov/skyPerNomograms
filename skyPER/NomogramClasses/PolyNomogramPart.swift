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
        //print("LIMITS \(limits)")
        var segm = Array(repeating: [0.0], count: 2)
        guard limits != nil else { return nil }
        if let lines = self.lines {
            for i in 0...1 {
                for line in lines {
                    //print("LINE \(line)")
                    if limits![i] == line.outer {
                        
                        for segment in line.segments {
                            let left = segment[0][1]
                            let right = segment[1][1]
                            //print("LEFT RIGHT \(left) \(right)")
                            let range = left < right ? left...right : right...left
                            //print("RANGE \(range) OUTER \(outer)")
                            if range ~= outer {
                                //print(segment)
                                let value = Interpolator.interpolate3D(argument: outer, pairs: segment)
                                segm[i] = [value, limits![i]]
                            }
                        }
                    }
                }
            }
           return Interpolator.interpolate3D(argument: inner, pairs: segm)
        }
        return nil
    }
}
