//
//  Sheet627.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/02/20.
//

import Foundation

struct Sheet628: Running {
    var oat: Double
    var elevation: Double
    var apu: Double
    var bleed: Double
    var partOne: Executable?
    var partTwo: ExecutableResult
    var partThree: Executable?
    
    init(oat: Double, elevation: Double, apu: Double, bleed: Double) {
        self.oat = oat
        self.elevation = elevation
        self.apu = apu
        self.bleed = bleed
        self.partOne = PolyNomogramPart(fileName: "628-1_v625")
        self.partTwo = ShiftedLinePart(fileName: "apu_on_628_v625")
        self.partThree = PolyNomogramPart(fileName: "628-3_v625")
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne?.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError(""))}
        print(one)
        var two = one
        if self.apu != 0 {
            switch partTwo.execute(one!, self.apu) {
            case .success(let result):
                two = result
            case .failure(let descr):
                print(descr)
            }
        }
        print(two)
        let three = partThree?.execute(self.bleed, two!)
        guard three != nil else { return .failure(.interpolateError(""))}
        return .success(three!)
    }
    
}
