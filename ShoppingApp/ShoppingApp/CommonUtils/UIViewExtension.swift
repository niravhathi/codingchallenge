//
//  UIViewExtension.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 12/04/24.
//

import Foundation
import UIKit
@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
           get { return layer.cornerRadius }
           set {
                 layer.cornerRadius = newValue

                 // If masksToBounds is true, subviews will be
                 // clipped to the rounded corners.
                 layer.masksToBounds = (newValue > 0)
           }
       }
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
}
