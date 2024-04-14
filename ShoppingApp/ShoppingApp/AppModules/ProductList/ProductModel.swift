//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation
// MARK: - ProductList
struct ProductList: Codable {
    var products: [Product]?
    var total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var title, description: String?
    var price: Int?
    var discountPercentage, rating: Double?
    var stock: Int?
    var brand, category: String?
    var thumbnail: String?
    var images: [String]?
    var quantity: Int?
}
