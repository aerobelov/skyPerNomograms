//
//  Sheet627.swift
//  skyPER
//
//  Created by Pavel Belov on 2023/02/20.
//

import Foundation

struct Sheet630reversed: Running {
    var oat: Double
    var elevation: Double
    var windComponent: Double
    var slope: Double
    var lda: Double
    var kSafe: Double
    var partOne: Executable
    var partTwo: Executable
    var partThree: Executable
    var partFour: Executable
    var partFive: EasyExecutable
    
    init(oat: Double, elevation: Double, windComponent: Double, slope: Double, kSafe: Double, lda: Double) {
        self.oat = oat
        self.elevation = elevation
        self.windComponent = windComponent
        self.slope = slope
        self.kSafe = kSafe
        self.lda = lda
        self.partOne = PolyNomogramPart(fileName: "630-1_v625")
        self.partTwo = SubtractNomogramPart()
        self.partThree = PolyNomogramPart(fileName: "629-3_v625")
        self.partFour = PolyReversed(fileName: "629-6_v625")
        self.partFive = SInglePart()
    
        
        
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError(""))}
        print(one)
        let five = partFive.execute(lda, kSafe) {
            a, b in return a*b
        }
        print(five)
        guard five != nil else { return .failure(.interpolateError(""))}
//        let two = partTwo.execute(one!, self.apu_shift)
//        guard two != nil else { return .failure(.interpolateError(""))}
//        print(two)
//        let three = partThree.execute(bleed, two!)
//        guard three != nil else { return .failure(.interpolateError(""))}
//        print(three)
//        let six = partSix.execute(bankAngle, gradient)
//        print(six)
//        guard six != nil else { return .failure(.interpolateError(""))}
        
//        let four = partFour.execute(three!, five!)
//        guard four != nil else { return .failure(.interpolateError(""))}
//        print(four)
        return .success(five!)
    }
    
}
