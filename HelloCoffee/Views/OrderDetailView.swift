//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/16.
//

import SwiftUI

struct OrderDetailView: View {
    let orderId: Int
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    
    private func deleteOrder() async {
        do {
            try await model.deleteOrder(orderId)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            if let order = model.orderById(orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNametext")
                    
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack {
                        Spacer() 
                        Button("Delete Order",  role: .destructive) {
                            Task {
                                await deleteOrder()
                            }
                        }
                        Spacer()
                        Button("Edit Order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                    .centerHorizontally()
                }
                .sheet(isPresented: $isPresented) {
                    AddCoffeeView(order: order)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    var config = Configuration()
    OrderDetailView(orderId: 1)
        .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
}
