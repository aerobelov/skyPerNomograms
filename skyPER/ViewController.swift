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
    
    
    //TEMP FUNCTION TO RUN APP
    func load() {
        let sheet = Sheet627(oat: 25, elevation: 4500, apu: 0, bleed: 2)
        switch sheet.run() {
        case .success(let res):
            print(res)  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        let sheet627a = Sheet627a(oat: 22, elevation: 4500, apu: 0, bleed: 2)
        switch sheet627a.run() {
        case .success(let res):
            print(res)  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        let sheet628 = Sheet628(oat: 22, elevation: 4900, apu: 0, bleed: 1)
        switch sheet628.run() {
        case .success(let res):
            print(res)  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        let sheet628a = Sheet628a(oat: 22, elevation: 6000, apu: 0, bleed: 1)
        switch sheet628a.run() {
        case .success(let res):
            print(res)  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        //629 fast forward to gradient
        let sheet629 = Sheet629(oat: 22, elevation: 6000, apu: 0, bleed: 1, weight: 34000, windComponent: -20, bankAngle: 30)
        print("PAGE 629")
        switch sheet629.run() {
        case .success(let res):
            print(res)  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        //629reversed rewind to weight
        let sheet629reversed = Sheet629reversed(oat: 13, elevation: 5000, apu: 0, bleed: 1, gradient: 5, windComponent: -26, bankAngle: 10)
        print("PAGE 629REV")
        switch sheet629reversed.run() {
        case .success(let res):
            print("RES \(res)")  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
        
        //630reversed rewind to weight
        let sheet630reversed = Sheet630reversed(oat: 0, elevation: 6000, windComponent: 0, slope: 0, kSafe: 1.67, lda: 920)
        print("PAGE 630REV")
        switch sheet630reversed.run() {
        case .success(let res):
            print("RES \(res)")  //USE RESULT
        case.failure(let error):
            print(error) //DISPLAY ERROR
        }
    }
}
