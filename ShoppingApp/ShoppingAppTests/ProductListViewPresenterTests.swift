//
//  ProductListViewPresenterTests.swift
//  ShoppingAppTests
//
//  Created by Nirav Hathi on 14/04/24.
//

import XCTest
@testable import ShoppingApp
final class ProductListViewPresenterTests: XCTestCase {
    var productListPresenter: ProductListPresenter!
    var productListVC: ProductListViewController!
    override func setUp() {
        productListVC =  ProductListViewController()
        productListPresenter = ProductListPresenter()
        productListVC.productListPresenter = productListPresenter
       
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResponseProductListToView() {
        
        let product =  Product(id: 8, title: "Microsoft Surface Laptop 4", description: "Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen.", price: 1499, discountPercentage: 4.43, rating: 4.3, stock: 68, brand: "Microsoft Surface", category: "laptops", thumbnail: "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/8/1.jpg",
            "https://cdn.dummyjson.com/product-images/8/2.jpg",
            "https://cdn.dummyjson.com/product-images/8/3.jpg",
            "https://cdn.dummyjson.com/product-images/8/4.jpg",
            "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg"
          ], quantity: nil)
        let product2 =  Product(id: 9, title: "Infinix INBOOK", description: "Infinix Inbook X1 Ci3 10th 8GB 256GB 14 Win10 Grey – 1 Year Warranty", price: 1099, discountPercentage: 11.83, rating: 4.54, stock: 96, brand: "Infinix", category: "laptops", thumbnail: "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/9/1.jpg",
            "https://cdn.dummyjson.com/product-images/9/2.png",
            "https://cdn.dummyjson.com/product-images/9/3.png",
            "https://cdn.dummyjson.com/product-images/9/4.jpg",
            "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg"
          ], quantity: nil)
        productListVC.responseProductListToView(productList: [product, product2], error: nil)
        XCTAssertEqual(productListVC.productList?.count, 2)
        XCTAssertEqual(productListVC.productList?.first?.title, "Microsoft Surface Laptop 4")
        XCTAssertEqual(productListVC.productList?.first?.brand, "Microsoft Surface")
        
    }

}
