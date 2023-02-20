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

protocol ExecutableResult {
    func execute(_ outer: Double, _ inner: Double) -> Result<Double, NomogramError>
}

protocol Running {
    func run() -> Result<Double, NomogramError>
}

