//
//  Constants.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//


import UIKit

struct Constant{
    static let apiURL = "https://dummyjson.com"
    static let productListURL = apiURL + "/products"
    static var productLimit: Int = 10
    static let decoder = JSONDecoder()
    
    //MARK: Tableview Cells
    static let productListTableViewCell = "ProductListTableViewCell"
    static let cartTableViewCell = "CartTableViewCell"
    static let productImagesCollectionViewCell =  "ProductImagesCollectionViewCell"
    
    //MARK: Controllers
    static let navigationViewController = "NavigationViewController"
    static let productDetailsViewController = "ProductDetailsViewController"
    static let productListViewController = "ProductListViewController"
    static let cartViewController = "CartViewController"
    
    //MARK: Errors
    static let noNewItems =  "There are no new Items to show"
    static let noInternet = "Internet not available."
    
    //MARK: Files
    static let mockProductList = "MockProductList"
    
    //MARK: Alert Messages
    static let removeCartSuccess = "Remove from cart Successfully"
    static let addCartSuccess = "Product Added to cart Successfully"

}
