//
//  CartPresenter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import Foundation

class CartPresenter: CartViewToPresenterProtocol {
    
    var interactor: CartPresenterToInteractorProtocol?
    var view: CartPresenterToViewProtocol?
    var router: CartPresenterToRouterProtocol?
    
    func requestCartDataToPresenter() {
        interactor?.requestCartDataToInteractor()
    }
    func requestRemoveFromCartToPresenter(name: String) {
        interactor?.requestRemoveFromCartToInteractor(name: name)
    }
}
extension CartPresenter:CartInteractorToPresenterProtocol {
    func responseSuccessRemoveCartToPresenter() {
        self.view?.responseSuccessRemoveCartToView()
    }
    
    func responseCartDataToPresenter(products: [Product]) {
        self.view?.responseCartDataToView(products: products)
    }
}
