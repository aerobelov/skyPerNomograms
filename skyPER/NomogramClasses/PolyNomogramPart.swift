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
    
    func executeReversed(_ bottom: Double, _ right: Double) -> Double? {
        
        if let lines = self.lines,
           var minimumDiff = lines.first?.outer {
            var nearest = 0.0
            for line in lines {
                for segment in line.segments {
                    let l = segment[0][1]
                    let r = segment[1][1]
                    let range = l < r ? l...r : r...l
                    if range ~= bottom {
                        let d = Interpolator.flatInterpolate(argument: bottom, from: (segment[0][1], segment[1][1]), to: (segment[0][0], segment[1][0]))
                        let delta = right - d
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
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        let limits = findNeigbours(argument: inner)
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


//class PartlyLinearPart: Executable {
//
//    var lines: [MyLine]?
//    let reader: NomoReader?
//
//    init(fileName: String) {
//        self.reader = NomoReader(file: fileName)
//        if let elevationNomogram = self.reader!.dataToPolyNomogram() {
//            self.lines = elevationNomogram.sorted(by: {$0.outer > $1.outer})
//        }
//    }
//
//    func findNeigbours(argument: Double) -> (Double, Double)? {
//        guard self.lines != nil else { return nil }
//        let bigger = self.lines!.first?.outer
//        let smaller = self.lines!.last?.outer
//
//        if let smaller = smaller, let bigger = bigger, smaller...bigger ~= argument {
//            let total = bigger - smaller
//            let step = Double(total)/Double((self.lines!.count - 1))
//            let upper = floor(argument/step)*step
//            let lower = ceil(argument/step)*step
//            return (lower, upper)
//        } else {
//            return nil
//        }
//    }
//
//    func execute(_ outer: Double, _ inner: Double) -> Double? {
//        let limits = findNeigbours(argument: inner)
//        var segm = Array(repeating: [0.0], count: 2)
//        guard limits != nil else { return nil }
//        if let lines = self.lines, let limits = limits {
//            for line in lines {
//                if limits.0 == line.outer {
//                    print("FOR \(limits.0)")
//                    for segment in line.segments.sorted(by: {$0[0][0] < $1[0][0]}) {
//                        let dx = segment[1][0] - segment[0][0]
//
//                        let dy = segment[1][1] - segment[0][1]
//                        print("DX=\(dx)  DY=\(dy)")
//                        let k = dy/dx
//                        print("K=\(k)")
//                        print("f(x) = \(segment[0][1]+k*9)")
//                    }
//                }
//            }
//        }
//        return nil
//    }
//}
