//
//  ProductListInteractor.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation


class ProductListInteractor:ProductListPresenterToInteractorProtocol{
    
    var presenter: ProductListInteractorToPresenterProtocol?
    private var products: ProductList?
    private let clientAPIManager: ClientAPIManager
    private let manager = DatabaseManager()
    var cartData: [Product]?
    init(clientAPIManager: ClientAPIManager) {
        self.clientAPIManager = clientAPIManager
    }
    func requestProductListToInteractor() {
        clientAPIManager.getDataWith(for: Constant.productListURL, parameters: ["limit":String(Constant.productLimit)]) { result in
            do {
                self.products = try Constant.decoder.decode(ProductList.self, from: result)
                self.presenter?.responseProductListToPresenter(productList: self.products?.products ?? [])
            } catch {
                print(error)
            }
        } completionFailure: { error in
            
        }
    }
    func getProductListCount(productList: [Product]) -> Int {
        return productList.count
    }
    func requestCartDataToInteractor() {
        cartData = []
        cartData = manager.prepareData()
        self.presenter?.responseCartDataToPresenter(productList: cartData ?? [])
    }
    
}
