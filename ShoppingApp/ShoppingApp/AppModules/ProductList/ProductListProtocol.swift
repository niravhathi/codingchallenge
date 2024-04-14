//
//  ProductListProtocol.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation
import UIKit

protocol ProductListViewToPresenterProtocol:AnyObject{
    
    var view: ProductListPresenterToViewProtocol? {get set}
    var interactor: ProductListPresenterToInteractorProtocol? {get set}
    var router: ProductListPresenterToRouterProtocol? {get set}
    func requestProductListToPresenter()
    func requestPresenterNavigateToProductDetails(navigationController: UINavigationController, product: Product)
    func requestPresenterNavigateToCart(navigationController: UINavigationController)
    func requestCartDataToPresenter()
}

protocol ProductListPresenterToInteractorProtocol:AnyObject {
    
    var presenter:ProductListInteractorToPresenterProtocol? {get set}
    func requestProductListToInteractor()
    func requestCartDataToInteractor()
}

protocol ProductListInteractorToPresenterProtocol:AnyObject {
    func responseProductListToPresenter(productList:[Product]?, error:Error?)
    func responseCartDataToPresenter(productList:[Product])
}

protocol ProductListPresenterToViewProtocol:AnyObject {
    
    func responseProductListToView(productList:[Product]?, error:Error?)
    func responseCartDataToView(productList: [Product])
    
}

protocol ProductListPresenterToRouterProtocol:AnyObject {
    
    static func createProductListModule()-> ProductListViewController
    func requestRouterNavigateToProductDetails(navigationController: UINavigationController, product: Product)
    func requestRouterNavigateToCart(navigationController: UINavigationController)
    
}


