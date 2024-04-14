//
//  CartViewController.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    private var cartData: [Product]?
    var cartPresenter: CartViewToPresenterProtocol?
    private var cartTotal: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        cartPresenter?.requestCartDataToPresenter()
        self.title = "Cart"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func removeProduct(_ sender: UIButton) {
        cartPresenter?.requestRemoveFromCartToPresenter(name: cartData?[sender.tag].title ?? "")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
     
     // Pass the selected object to the new view controller.
    }
    */

}
extension CartViewController: CartPresenterToViewProtocol {
    func responseSuccessRemoveCartToView() {
        self.showAlertMessage(title: "Success", message: "Remove from cart Successfully")
        cartPresenter?.requestCartDataToPresenter()
    }
    
    func responseCartDataToView(products: [Product]) {
        self.cartData = products
        self.cartTableView.reloadData()
    }

}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iCell =  tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        let total = (cartData?[indexPath.row].price ?? 0) * (self.cartData?[indexPath.row].quantity ?? 0)
        iCell.priceLabel.text = "$\(total)"
        iCell.productNameLabel.text = self.cartData?[indexPath.row].title
        iCell.productBrand.text = self.cartData?[indexPath.row].brand
        iCell.removeProductButton.tag = indexPath.row
        if let imgUrl = URL(string: cartData?[indexPath.row].thumbnail ?? "") {
            iCell.productImage.loadImageWithUrl(imgUrl)
        }
        iCell.productQuantityLabel.text = "Qty: \(self.cartData?[indexPath.row].quantity ?? 0)"
        return iCell
    }
    
    
}
