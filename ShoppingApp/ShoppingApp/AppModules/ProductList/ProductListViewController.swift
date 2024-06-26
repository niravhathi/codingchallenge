//
//  ProductListViewController.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var cartItemsCountLabel: UILabel!
    @IBOutlet weak var productListTableView: UITableView!
    var productListPresenter:ProductListViewToPresenterProtocol?
    private var productList:[Product]?
    private var isLoadingList : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        productListPresenter?.requestProductListToPresenter()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListPresenter?.requestCartDataToPresenter()
    }
    
    @IBAction func rightButtonAction(sender: Any) {
        if let navigationController =  self.navigationController {
            productListPresenter?.requestPresenterNavigateToCart(navigationController: navigationController)
        }
        
    }
    
}
extension ProductListViewController: ProductListPresenterToViewProtocol {
    func responseProductListToView(productList: [Product]?, error: Error?) {
        if error == nil {
            self.productList = productList
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.productListTableView.reloadData()
            }
        } else {
            self.showAlertMessage(title: "Error", message: error?.localizedDescription)
        }
    }
    func responseCartDataToView(productList: [Product]) {
        //showing cart item on badge
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.productListTableViewCell, for: indexPath) as! ProductListTableViewCell
        if let product =  productList?[indexPath.row] {
            cell.config(product:  product)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigationController = self.navigationController, let product = productList?[indexPath.row] {
            self.productListPresenter?.requestPresenterNavigateToProductDetails(navigationController: navigationController, product: product)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (self.productList?.count ?? 1) - 1
        if indexPath.row == lastItem {
            Constant.productLimit = Constant.productLimit < 100 ? Constant.productLimit + 10 : Constant.productLimit
            productListPresenter?.requestProductListToPresenter()
        }
    }
}

