//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    private func populateOrders() async {
        do {
            try await model.populatedOrders()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderCellView(order: order)
            }
            .task {
                await populateOrders()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView().environmentObject(CoffeeModel(webservice: Webservice()))
}
