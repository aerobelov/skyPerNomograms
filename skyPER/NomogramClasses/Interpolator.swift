//
//  FlatInterpolator.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/20.
//

import Foundation

class Interpolator {
    static func flatInterpolate(argument: Double, from: Pair, to: Pair) -> Double{
        let k = from.1-from.0
        let unit = k == 0 ? 0 : (to.1-to.0)/k
        let delta = argument - from.0
        return to.0 + delta * unit
    }
    
    static func interpolate3D(argument: Double, pairs: Segment) -> Double {
        let deltaA = pairs[1][1] - pairs[0][1]
        let deltaB = pairs[1][0] - pairs[0][0]
        let mini = deltaB == 0 ? 0 : deltaB/deltaA
        let diff = pairs[0][0] + mini * (argument - pairs[0][1])
        return diff
    }
}
