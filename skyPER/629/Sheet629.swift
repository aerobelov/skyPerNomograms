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
    var weight: Double
    var windComponent: Double
    var bankAngle: Double
    var partOne: Executable
    var partTwo: Executable
    var partThree: Executable
    var partFour: Executable
    var partFive: Executable
    var partSix: Executable
    var apu_shift: Double {
        return apu == 0 ? 0 : -0.2
    }
    
    init(oat: Double, elevation: Double, apu: Double, bleed: Double, weight: Double, windComponent: Double, bankAngle: Double) {
        self.oat = oat
        self.elevation = elevation
        self.apu = apu
        self.bleed = bleed
        self.weight = weight
        self.windComponent = windComponent
        self.bankAngle = bankAngle
        self.partOne = PolyNomogramPart(fileName: "629-1_v625")
        self.partTwo = SubtractNomogramPart()
        self.partThree = PolyNomogramPart(fileName: "629-3_v625")
        self.partFour = PolyNomogramPart(fileName: "629-4_v625")
        self.partFive = PolyNomogramPart(fileName: "629-5_v625")
        self.partSix = PolyNomogramPart(fileName: "629-6_v625")
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError(""))}
        let two = partTwo.execute(one!, self.apu_shift)
        guard two != nil else { return .failure(.interpolateError(""))}
        let three = partThree.execute(bleed, two!)
        guard three != nil else { return .failure(.interpolateError(""))}
        let four = partFour.execute(weight, three!)
        guard four != nil else { return .failure(.interpolateError(""))}
        let five = partFive.execute(windComponent, four!)
        guard five != nil else { return .failure(.interpolateError(""))}
        let six = partSix.execute(bankAngle, five!)
        
        return .success(six!)
    }
    
}
