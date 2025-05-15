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
    @State private var errors: AddCoffeeErrors = .init()
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var model: CoffeeModel
    
    var isValid: Bool {
        errors = AddCoffeeErrors()
        
        if name.isEmpty {
            errors.name = "Name cannot be empty"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee Name cannot be empty"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty"
        } else if (!price.isNumeric) {
            errors.price = "Price must be a number"
        } else if price.isLessThan(number: 1) {
            errors.price = "Price must be greater than 0"
        }
        
        return errors.name.isEmpty &&
        errors.coffeeName.isEmpty &&
        errors.price.isEmpty
    }
    
    private func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
        do {
            try await model.placeOrder(order)
            dismiss()
            
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                
                Text(errors.name)
                    .visible(errors.name.isNotEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                
                Text(errors.coffeeName)
                    .visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                
                Text(errors.price)
                    .visible(errors.price.isNotEmpty)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                Picker("Size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.self) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                
                Button("Place Order") {
                    if isValid {
                        // MARK: - TODO
                        Task {
                            await placeOrder()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            }
            .navigationTitle("Add Coffee")
        }
    }
}

#Preview {
    AddCoffeeView()
}

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}
