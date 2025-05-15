//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/14.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
    
    @StateObject private var model: CoffeeModel
    
    init() {
        let webservice = Webservice()
        _model = StateObject(wrappedValue: .init(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
