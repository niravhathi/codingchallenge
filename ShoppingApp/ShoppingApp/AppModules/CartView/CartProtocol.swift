//
//  CartProtocol.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import Foundation
protocol CartViewToPresenterProtocol: AnyObject {
    var interactor: CartPresenterToInteractorProtocol? {get set}
    var view: CartPresenterToViewProtocol? {get set}
    var router: CartPresenterToRouterProtocol? {get set}
    func requestCartDataToPresenter()
    func requestRemoveFromCartToPresenter(name: String)
}

protocol CartPresenterToInteractorProtocol: AnyObject {
    var presenter: CartInteractorToPresenterProtocol? {get set}
    func requestCartDataToInteractor()
    func requestRemoveFromCartToInteractor(name: String)
}

protocol CartInteractorToPresenterProtocol: AnyObject {
    func responseCartDataToPresenter(products: [Product])
    func responseSuccessRemoveCartToPresenter()
}

protocol CartPresenterToViewProtocol: AnyObject {
    func responseCartDataToView(products: [Product])
    func responseSuccessRemoveCartToView()
}
protocol CartPresenterToRouterProtocol: AnyObject {
    static func createCartModule()-> CartViewController
}

