//
//  LinearNomogramPart.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

struct SIngleOperationPart: EasyExecutable {
    func execute(_ outer: Double, _ inner: Double, operation: (Double, Double) -> Double) -> Double? {
        return operation(outer, inner)
    }
}
