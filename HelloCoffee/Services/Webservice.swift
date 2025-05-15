//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
/// Webservice is responsible for making a request to the server and get the data that you need.
///

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case decodingError
}

class Webservice {
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: EndPoints.allOrders.path) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        
        return orders
    }
}
