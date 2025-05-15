//
//  Order.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import Foundation


struct Order: Codable, Identifiable, Hashable {
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
    
    
}
