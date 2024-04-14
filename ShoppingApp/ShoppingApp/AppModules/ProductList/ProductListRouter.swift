//
//  ProductListRouter.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation
import UIKit
class ProductListRouter:ProductListPresenterToRouterProtocol{

    static func createProductListModule() -> ProductListViewController {
        
        let viewController = ProductListRouter.mainstoryboard.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        
        let presenter: ProductListViewToPresenterProtocol & ProductListInteractorToPresenterProtocol = ProductListPresenter()
        let interactor: ProductListPresenterToInteractorProtocol = ProductListInteractor(clientAPIManager: ClientAPIManager())
        let router:ProductListPresenterToRouterProtocol = ProductListRouter()
        
     
        viewController.productListPresenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return viewController
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    func requestRouterNavigateToProductDetails(navigationController: UINavigationController, product: Product) {
        let productDetails = ProductDetailsRouter.createProductDetailsModule(product: product)
        
        navigationController.pushViewController(productDetails,animated: true)
        
    }
    func requestRouterNavigateToCart(navigationController: UINavigationController) {
        let cartView = CartRouter.createCartModule()
        navigationController.pushViewController(cartView,animated: true)
        
    }
}
