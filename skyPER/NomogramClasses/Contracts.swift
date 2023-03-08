//
//  Contracts.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation


typealias Pair = (Double, Double)
typealias Segment = [[Double]]

protocol Executable {
    func execute(_ outer: Double, _ inner: Double) -> Double?
}

extension Executable {
    func segmentContains(argument: Double, segment: Segment, argumentNumber: Int) -> Bool {
        let first = segment[0][argumentNumber]
        let second = segment[1][argumentNumber]
        let range = first < second ? first...second : second...first
        return range ~= argument
    }
}

protocol ExecutableResult {
    func execute(_ outer: Double, _ inner: Double) -> Result<Double, NomogramError>
}

protocol Running {
    func run() -> Result<Double, NomogramError>
}

