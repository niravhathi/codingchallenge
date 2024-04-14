//
//  ProductDetailsPresenter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import Foundation


import Foundation
class ProductDetailsPresenter:ProductDetailsViewToPresenterProtocol{
   
    var view: ProductDetailsPresenterToViewProtocol?
    var interactor: ProductDetailsPresenterToInteractorProtocol?
    var router: ProductDetailsPresenterToRouterProtocol?
    var product: Product?
    init(product:Product?) {
        self.product = product
    }
    func requestProductDetailsToPresenter() {
        view?.responseProductDetailsToView(product: self.product ?? Product())
    }
    func requestAddToCartPresenter(product: Product) {
        interactor?.requestAddToCartInteractor(product: product)
    }
    
}
extension ProductDetailsPresenter: ProductDetailsInteractorToPresenterProtocol {
    func responseAddToCartToPresenter() {
        view?.responseAddToCartToView()
    }
    
}
