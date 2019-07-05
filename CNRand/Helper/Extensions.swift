//
//  Extensions.swift
//  CNRand
//
//  Created by Augusto Reis on 03/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import UIKit


protocol ReusableView {
}

extension ReusableView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
