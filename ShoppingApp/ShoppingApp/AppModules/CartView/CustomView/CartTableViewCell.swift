//
//  CartTableViewCell.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 13/04/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var removeProductButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImage: ImageLoader!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
