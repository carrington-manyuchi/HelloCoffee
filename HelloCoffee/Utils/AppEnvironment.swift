//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/15.
//

import Foundation

enum EndPoints {
    case allOrders
    case placeOrder
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        // read the value from environment variables
        
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
        
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me/orders")!
        case .test:
            return  URL(string: "https://island-bramble.glitch.me/orders")!
        }
    }
}
