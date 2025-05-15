//
//  String + Extensions.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/15.
//

import Foundation


extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func isLessThan(number: Double) -> Bool {
        if !self.isNumeric {
            return false
        }
        guard let value = Double(self) else {
            return false
        }
        return value < number
    }
}
