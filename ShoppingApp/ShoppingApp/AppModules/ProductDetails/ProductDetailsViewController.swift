//
//  ProductDetailsViewController.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 09/04/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    var productDetailsPresenter: ProductDetailsViewToPresenterProtocol?
    var productListPresenter: ProductListPresenter?
    private var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productDetailsPresenter?.requestProductDetailsToPresenter()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     */
    @IBAction func addToCartClicked(_ sender: Any) {
        if let product = self.product {
            self.productDetailsPresenter?.requestAddToCartPresenter(product: product)
        }
       
    }
    
    func setupView() {
        self.descriptionLabel.text = self.product?.description
        self.ratingLabel.text = "\(self.product?.rating ?? 0)"
        self.nameLabel.text = self.product?.title
        self.priceLabel.text = "$\(self.product?.price ?? 0)" + "(\(self.product?.discountPercentage ?? 0)% off)"
        self.brandLabel.text = self.product?.brand
        self.pageControl.numberOfPages = self.product?.images?.count ?? 0
    }
}
extension ProductDetailsViewController: ProductDetailsPresenterToViewProtocol {
    func responseProductDetailsToView(product: Product) {
        self.product = product
        self.productImagesCollectionView.reloadData()
        setupView()
    }
    func responseAddToCartToView() {
        self.showAlertMessage(title: "Success", message: Constant.addCartSuccess)
    }
}
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.product?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.productImagesCollectionViewCell, for: indexPath) as! ProductImagesCollectionViewCell
        if let imgUrl = product?.images?[indexPath.row] {
            iCell.configuCell(proudctImage: imgUrl)
        }
        return iCell
    }
}
extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
extension ProductDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.productImagesCollectionView {
            let scrollviewPos = scrollView.contentOffset.x / view.frame.width
            pageControl.currentPage = Int(scrollviewPos)
        }
    }
}
