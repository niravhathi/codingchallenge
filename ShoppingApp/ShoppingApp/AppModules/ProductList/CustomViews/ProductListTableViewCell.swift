//
//  ProductListTableViewCell.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 10/04/24.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: ImageLoader!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardSetup()
        // Initialization code
    }
    func cardSetup() {
            self.cardView.alpha = 1
            self.cardView.layer.masksToBounds = false
            self.cardView.layer.cornerRadius = 1
            self.cardView.layer.shadowOffset = CGSizeMake(0, 0.7)
            self.cardView.layer.shadowRadius = 1
            self.cardView.layer.shadowOpacity = 0.5
            self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price ?? 0)" + "(\(product.discountPercentage ?? 0)% off)"
        ratingLabel.text = "\(product.rating ?? 0)"
        descriptionLabel.text = product.description
        if let imgUrl = URL(string: product.thumbnail ?? "") {
            thumbnailImage.loadImageWithUrl(imgUrl)
        }
        backgroundColor = UIColor.clear
    }

}
