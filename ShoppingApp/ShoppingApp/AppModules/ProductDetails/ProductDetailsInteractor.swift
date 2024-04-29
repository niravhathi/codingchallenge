//
//  ProductDetailsInteractor.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation


class ProductDetailsInteractor:ProductDetailsPresenterToInteractorProtocol{
    internal var databaseManager: DatabaseManager?
    var presenter: ProductDetailsInteractorToPresenterProtocol?
    func requestAddToCartInteractor(product: Product) {
        databaseManager = DatabaseManager()
        databaseManager?.addProduct(product: product)
        self.presenter?.responseAddToCartToPresenter()
    }
}
