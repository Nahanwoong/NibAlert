//
//  CellModel.swift
//  NibAlert_Example
//
//  Created by MacBook-Na on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct CellModel {
    var name: String
    var isSelected: Bool
    
    init(name: String) {
        self.name = name
        self.isSelected = false
    }
}
