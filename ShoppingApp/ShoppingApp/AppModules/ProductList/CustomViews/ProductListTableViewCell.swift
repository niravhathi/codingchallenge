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
            // if you like rounded corners
            self.cardView.layer.shadowOffset = CGSizeMake(0, 0.7)
            //%%% this shadow will hang slightly down and in the center
            self.cardView.layer.shadowRadius = 1
            //%%% I prefer thinner, subtler shadows, but you can play with this
            self.cardView.layer.shadowOpacity = 0.5
            //%%% same thing with this, subtle is better for me
            //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
            //let path: UIBezierPath = UIBezierPath(rect: self.cardView.bounds)
            //self.cardView.layer.shadowPath = path.CGPath
            self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            //%%% I prefer choosing colors programmatically than on the storyboard
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
