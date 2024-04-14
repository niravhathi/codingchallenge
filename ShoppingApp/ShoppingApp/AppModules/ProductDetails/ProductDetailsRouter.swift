//
//  ProductDetailsRouter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation
import UIKit
class ProductDetailsRouter:ProductDetailsPresenterToRouterProtocol{
    
    static func createProductDetailsModule(product: Product?) -> ProductDetailsViewController {
        
        let view = ProductDetailsRouter.mainstoryboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        
        let presenter: ProductDetailsViewToPresenterProtocol & ProductDetailsInteractorToPresenterProtocol = ProductDetailsPresenter(product: product)
        let interactor: ProductDetailsPresenterToInteractorProtocol = ProductDetailsInteractor()
        let router:ProductDetailsPresenterToRouterProtocol = ProductDetailsRouter()
        
        view.productDetailsPresenter = presenter
        view.productListPresenter = ProductListPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
