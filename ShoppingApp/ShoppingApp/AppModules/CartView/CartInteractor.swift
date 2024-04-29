//
//  CartInteractor.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import Foundation

class CartInteractor: CartPresenterToInteractorProtocol {
    var presenter: CartInteractorToPresenterProtocol?
    private let manager = DatabaseManager()
    func requestCartDataToInteractor() {
            let cartData: [Product] = manager.prepareData()
            presenter?.responseCartDataToPresenter(products: cartData)
    }
    func requestRemoveFromCartToInteractor(name: String) {
        manager.removeFromName(stringName: name)
        presenter?.responseSuccessRemoveCartToPresenter()
    }
}

