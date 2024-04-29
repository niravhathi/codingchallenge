//
//  ProductListPresenter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation
import UIKit
class ProductListPresenter:ProductListViewToPresenterProtocol{
    
    var view: ProductListPresenterToViewProtocol?
    var interactor: ProductListPresenterToInteractorProtocol?
    var router: ProductListPresenterToRouterProtocol?
    
    func requestProductListToPresenter() {
        interactor?.requestProductListToInteractor()
    }
    func requestPresenterNavigateToProductDetails(navigationController: UINavigationController, product: Product) {
        router?.requestRouterNavigateToProductDetails(navigationController: navigationController, product: product)
    }
    func requestPresenterNavigateToCart(navigationController: UINavigationController) {
        router?.requestRouterNavigateToCart(navigationController: navigationController)
    }
    func requestCartDataToPresenter() {
        interactor?.requestCartDataToInteractor()
    }
}
extension ProductListPresenter: ProductListInteractorToPresenterProtocol {
    func responseProductListToPresenter(productList: [Product]?, error:Error?) {

        view?.responseProductListToView(productList: productList, error:error)
    }
    func responseCartDataToPresenter(productList: [Product]) {
        view?.responseCartDataToView(productList: productList)
    }
        
    }

