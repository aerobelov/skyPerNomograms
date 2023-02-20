// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MyNomogramm: Codable {
    let lines: [MyLine]
}

// MARK: - Line
struct MyLine: Codable {
    let outer: Double
    let segments: [[[Double]]]
}

struct LinedObject: Codable {
    let `in`: Double
    let out: Double
}

struct ShiftedLine : Codable {
    let lines: [LinedObject]
}
