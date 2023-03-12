//
//  LinearNomogramPart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

class SubtractNomogramPart: Executable {
    
    func execute(_ outer: Double, _ inner: Double) -> Double? {
        return outer - inner
    }
    func executeReversed(_ outer: Double, _ inner: Double) -> Double? {
        return outer - inner
    }
}

struct SInglePart: EasyExecutable {
    func execute(_ outer: Double, _ inner: Double, operation: (Double, Double) -> Double) -> Double? {
        print(outer, inner)
        return operation(outer, inner)
    }
}
