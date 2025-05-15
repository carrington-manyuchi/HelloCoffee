//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/15.
//

import SwiftUI

struct AddCoffeeView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    var body: some View {
        
        Form {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")
            
            TextField("Coffee Name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            
            TextField("Price", text: $price)
                .accessibilityIdentifier("price")
                
            Picker("Size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.self) { size in
                    Text(size.rawValue).tag(size)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical)
            
            Button("Place Order") {
                
            }
            .accessibilityIdentifier("placeOrderButton")
            .centerHorizontally()
        }
    }
}

#Preview {
    AddCoffeeView()
}
  
