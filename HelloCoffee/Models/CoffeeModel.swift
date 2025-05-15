//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import Foundation


class CoffeeModel: ObservableObject {
    
    @Published private(set) var orders: [Order] = []
    
    let webservice: Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func populatedOrders() async throws {
        orders = try await webservice.getOrders()
    }
}
