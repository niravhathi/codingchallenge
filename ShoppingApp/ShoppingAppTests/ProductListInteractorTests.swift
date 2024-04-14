//
//  ProductListInteractorTests.swift
//  ShoppingAppTests
//
//  Created by Nirav Hathi on 13/04/24.
//

import XCTest
@testable import ShoppingApp
final class ProductListInteractorTests: XCTestCase {
    var productListInteractor: ProductListInteractor!
    override func setUp() {
        let mockClientAPIManager = MockClientAPIManager()
        productListInteractor = ProductListInteractor(netWorkService: mockClientAPIManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestProductListToInteractor() {
        let expectation = self.expectation(description: "Fetch Product data")
        productListInteractor.requestProductListToInteractor()
        XCTAssertEqual(productListInteractor.products?.products?.count, 10)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5.0)
        
    }
    
}
