//
//  ProductDetailsProtocol.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation

protocol ProductDetailsViewToPresenterProtocol:AnyObject{
    var view: ProductDetailsPresenterToViewProtocol? {get set}
    var interactor: ProductDetailsPresenterToInteractorProtocol? {get set}
    var router: ProductDetailsPresenterToRouterProtocol? {get set}
    
    func requestProductDetailsToPresenter()
    func requestAddToCartPresenter(product: Product)
}

protocol ProductDetailsPresenterToRouterProtocol:AnyObject {
    static func createProductDetailsModule(product: Product?)-> ProductDetailsViewController
}

protocol ProductDetailsPresenterToInteractorProtocol:AnyObject {
    var presenter:ProductDetailsInteractorToPresenterProtocol? {get set}
    var databaseManager:DatabaseManager? {get set}
    func requestAddToCartInteractor(product: Product)
}
protocol ProductDetailsPresenterToViewProtocol:AnyObject {
    func responseProductDetailsToView(product: Product)
    func responseAddToCartToView()
}
protocol ProductDetailsInteractorToPresenterProtocol:AnyObject {
    func responseAddToCartToPresenter()
}
