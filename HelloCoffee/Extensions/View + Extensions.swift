//
//  View + Extensions.swift
//  HelloCoffee
//
//  Created by Manyuchi, Carrington C on 2025/05/15.
//

import Foundation
import SwiftUI


extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        switch value {
        case true:
            self
        case false:
            EmptyView()
        }
    }
    
}
