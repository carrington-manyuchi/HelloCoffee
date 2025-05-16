//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: CoffeeModel
    
    private func populateOrders() async {
        do {
            try await model.populatedOrders()
        } catch {
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet: IndexSet) async {
        for index in indexSet {
            
           let order =  model.orders[index]
            guard let orderId = order.id else { continue }
            do {
                try await model.deleteOrder(orderId)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available...")
                        .accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            OrderCellView(order: order)
                        }
                        .onDelete { indexSet in
                            Task { 
                                await deleteOrder(indexSet)
                            }
                        }
                    }
                }
            }
            .task {
                await populateOrders()
            }
            .padding()
            .navigationTitle("Hello Coffee")
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            }) 
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
        }
    }
}

#Preview {
    var config = Configuration()
    ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}
