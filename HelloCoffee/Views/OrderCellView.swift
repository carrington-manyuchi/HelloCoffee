//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import SwiftUI

struct OrderCellView: View {
    
    let order: Order
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).accessibilityIdentifier("orderNameText")
                    .font(.body)
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
                    .font(.caption)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}


#Preview {
    OrderCellView(order: Order(id: 1, name: "John Doe", coffeeName: "Latte", total: 2.5, size: .large))
        .padding()
}
