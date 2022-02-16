//
//  Utils.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import Foundation

func loadFileFromNib(name:String, type:String) -> URL {
    let path = Bundle.main.path(forResource: name, ofType: type) ?? ""
    let streamURL = URL.init(fileURLWithPath: path)
    return streamURL
}

func onMain(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
    
}

func onGlobal(after: Double = 0,qos: DispatchQoS, exexute: @escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + after, qos: qos, execute: exexute)
}
