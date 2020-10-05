//
//  ViewModel.swift
//  MVVM-Closure
//
//  Created by Fábio Salata on 05/10/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import Foundation

struct ViewModel {
    var updater: (Int) -> Void = { _ in
        fatalError("updater not set")
    }
    
    private var model = Model() {
        didSet {
            updater(model.value)
        }
    }
    
    mutating func increaseValue() {
        model.increaseValue()
    }
}

struct Model {
    private(set) var value = 0
    
    mutating func increaseValue() {
        value += 1
    }
}
