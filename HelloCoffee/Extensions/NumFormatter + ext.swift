//
//  NumFormatter + ext.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import Foundation

import Foundation

extension NumberFormatter {
    public static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}
