//
//  Errors.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/01/08.
//

import Foundation

enum NomogramError: Error {
    case interpolateError(String)
    case outOfLimits(String)
    case outOfEnvelop(String)
}
