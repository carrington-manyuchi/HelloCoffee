//
//  HelloCoffeeUITests.swift
//  HelloCoffeeUITests
//
//  Created by Manyuchi, Carrington C on 2025/05/15.
//

import XCTest

final class when_adding_a_new_coffee_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        //go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeTextField.tap()
        coffeeTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("3.20")
        
        //place the order
        placeOrderButton.tap()
                
    }
    
    func testShouldDisplayCoffeeOrderInListSuccessfully() throws {
        
        XCTAssertEqual("John", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee", app.staticTexts["coffeeNameAndSizeTexts"].label)
        XCTAssertEqual("R3.20", app.staticTexts["coffeePriceText"].label)
    }
    
    override func tearDownWithError() throws {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "")!) else {
                return
            }
            
            let (_, _) = try await URLSession.shared.data(from: url)
        }
    }
}

final class HelloCoffeeUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testShouldMakeSureNoOrdersMessagesIsDisplayed() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders available...", app.staticTexts["noOrdersText"].label)
    }

}
