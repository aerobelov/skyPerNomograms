//
//  Sheet627.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/02/20.
//

import Foundation

struct Sheet629: Running {
    var oat: Double
    var elevation: Double
    var apu: Double
    var bleed: Double
    var partOne: Executable
    var partTwo: Executable
    var partThree: Executable
    var partFour: Executable
    var partFive: Executable
    var apu_shift: Double {
        return apu == 0 ? 0 : -0.2
    }
    
    init(oat: Double, elevation: Double, apu: Double, bleed: Double) {
        self.oat = oat
        self.elevation = elevation
        self.apu = apu
        self.bleed = bleed
        self.partOne = PolyNomogramPart(fileName: "629-1_v625")
        self.partTwo = SubtractNomogramPart()
        self.partThree = PolyNomogramPart(fileName: "629-3_v625")
        self.partFour = SubtractNomogramPart() // DUMMY
        self.partFive = SubtractNomogramPart() //DUMMY
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError(""))}
        let two = partTwo.execute(one!, self.apu_shift)
        guard two != nil else { return .failure(.interpolateError(""))}
        let three = partThree.execute(bleed, two!)
        return .success(three!)
    }
    
}
