//
//  ProductImagesCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 12/04/24.
//

import UIKit

class ProductImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: ImageLoader!
    func configuCell(proudctImage: String) {
        if let imgUrl = URL(string: proudctImage) {
           productImage.loadImageWithUrl(imgUrl)
        }
    }
}
