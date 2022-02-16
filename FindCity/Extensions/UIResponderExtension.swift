//
//  UIResponderExtension.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import UIKit

extension UIResponder {
    static var identifier:String {
        return String(describing: self)
    }
}
