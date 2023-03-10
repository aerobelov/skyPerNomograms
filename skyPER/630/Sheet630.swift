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
        self.partTwo = PolySelectable(fileName: "630-2_v625")
        self.partThree = PolyReversed(fileName: "630-3_v625")
        self.partFour = PolyReversed(fileName: "630-4_v625")
        self.partFive = SIngleOperationPart()
    }
    
    func run() -> Result<Double, NomogramError> {
        let one = partOne.execute(self.oat, self.elevation)
        guard one != nil else { return .failure(.interpolateError("630 part 1 error"))}
        print("630 1=\(one)")
        let five = partFive.execute(lda, kSafe) {
            return $0*$1
        }
        print("630 5=\(five)")
        guard five != nil else { return .failure(.interpolateError("630 part 5 error"))}
        let four = partFour.execute(slope, five!)
        guard four != nil else { return .failure(.interpolateError("630 part 4 error"))}
        print("630 4=\(four)")
        let three = partThree.execute(windComponent, four!)
        guard three != nil else { return .failure(.interpolateError("630 part 3 error"))}
        print("630 3=\(three)")
        let two = partTwo.execute(one!, three!)
        guard two != nil else { return .failure(.interpolateError("630 part 2 error"))}
        print("630 2=\(two)")
        
        return .success(two!)
    }
    
}
