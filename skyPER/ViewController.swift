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
    }
}
