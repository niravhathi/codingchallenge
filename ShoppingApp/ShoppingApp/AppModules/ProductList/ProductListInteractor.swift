//
//  ProductListInteractor.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import Foundation


class ProductListInteractor:ProductListPresenterToInteractorProtocol{
    
    var presenter: ProductListInteractorToPresenterProtocol?
    var products: ProductList?
    private let netWorkService: NetworkingService
    private let manager = DatabaseManager()
    var cartData: [Product]?
    init(netWorkService: NetworkingService) {
        self.netWorkService = netWorkService
    }
    func requestProductListToInteractor() {
        netWorkService.getDataWith(for: Constant.productListURL, parameters: ["limit":String(Constant.productLimit)]) { result in
            switch result {
                case .success(let data):
                do {
                    self.products = try Constant.decoder.decode(ProductList.self, from: data)
                    if let products =  self.products?.products {
                        self.presenter?.responseProductListToPresenter(productList: products, error: nil)
                    } else {
                        self.presenter?.responseProductListToPresenter(productList: nil, error: "Service Unavailable." as? Error)
                    }
                  
                } catch {
                    self.presenter?.responseProductListToPresenter(productList: nil, error: error)
                }
                case .failure(let error):
                self.presenter?.responseProductListToPresenter(productList: nil, error: error)
                }
           
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
