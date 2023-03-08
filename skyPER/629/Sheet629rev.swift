//
//  Sheet627.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/02/20.
//

import Foundation

struct Sheet629reversed: Running {
    var oat: Double
    var elevation: Double
    var apu: Double
    var bleed: Double
    var bankAngle: Double
    var windComponent: Double
    var gradient: Double
    var partOne: Executable
    var partTwo: Executable
    var partThree: Executable
    var partFour: Executable
    var partFive: Executable
    var partSix: Executable
    var apu_shift: Double {
        return apu == 0 ? 0 : -0.2
    }
    
    init(oat: Double, elevation: Double, apu: Double, bleed: Double, gradient: Double, windComponent: Double, bankAngle: Double) {
        self.oat = oat
        self.elevation = elevation
        self.apu = apu
        self.bleed = bleed
        self.gradient = gradient
        self.windComponent = windComponent
        self.bankAngle = bankAngle
        self.partOne = PolyNomogramPart(fileName: "629-1_v625")
        self.partTwo = SubtractNomogramPart()
        self.partThree = PolyNomogramPart(fileName: "629-3_v625")
        self.partSix = PolyReversed(fileName: "629-6_v625")
        self.partFive = PolyReversed(fileName: "629-5_v625")
        self.partFour = PolySelectable(fileName: "629-4_v625")
        
        
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError(""))}
        print(one)
        let two = partTwo.execute(one!, self.apu_shift)
        guard two != nil else { return .failure(.interpolateError(""))}
        print(two)
        let three = partThree.execute(bleed, two!)
        guard three != nil else { return .failure(.interpolateError(""))}
        print(three)
        let six = partSix.execute(bankAngle, gradient)
        print(six)
        guard six != nil else { return .failure(.interpolateError(""))}
        let five = partFive.execute(windComponent, six!)
        print(five)
        guard five != nil else { return .failure(.interpolateError(""))}
        let four = partFour.execute(three!, five!)
        guard four != nil else { return .failure(.interpolateError(""))}
        print(four)
        return .success(four!)
    }
    
}
