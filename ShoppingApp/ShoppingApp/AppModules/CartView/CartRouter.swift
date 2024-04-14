//
//  CartRouter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import Foundation
import UIKit
class CartRouter: CartPresenterToRouterProtocol {
    static func createCartModule() -> CartViewController {
        let view = ProductDetailsRouter.mainstoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        let presenter: CartViewToPresenterProtocol & CartInteractorToPresenterProtocol = CartPresenter()
        let router: CartPresenterToRouterProtocol = CartRouter()
        let interactor: CartPresenterToInteractorProtocol = CartInteractor()
        view.cartPresenter  = presenter
        presenter.view = view
        presenter.interactor =  interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
