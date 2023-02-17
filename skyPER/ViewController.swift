//
//  MyViewController.swift
//  skyPER
//
//  Created by Pavel Belov on 2022/12/21.
//

import UIKit

final class MyController: UIViewController {
    
    var bleed = BleedType_627a.skv
    var apu = APUType_627a.off
    var elevation: Double = 5000
    var aot: Double = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    func load() {
        //First part (upper)
        let partOne = PolyNomogramPart(fileName: "627a_converted")
        let result1 = partOne.execute(aot, elevation)
        
        guard result1 != nil else { return }
        print("RESULT ALT AND TEMP = \(result1!)")
        
        //APU
        let partTwo = ShiftedLinePart(fileName: apu.rawValue)
        let result2 = partTwo.execute(result1!, 0.0)
        print("RESULT APU = \(result2!)")
        
        guard result2 != nil else { return }
        
        //Bleed
        let partThree = ShiftedLinePart(fileName: bleed.rawValue)
        let result3 = partThree.execute(result2!, 0.0)
        print("RESULT BLEED = \(result3!)")
        
        
    }
    
    
    
}
