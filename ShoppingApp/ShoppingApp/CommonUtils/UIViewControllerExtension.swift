//
//  UIViewControllerExtension.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 12/04/24.
//

import Foundation
import UIKit
extension UIViewController{
    
    public func showAlertMessage(title: String, message: String?){
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alertMessagePopUpBox.addAction(okButton)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.present(alertMessagePopUpBox, animated: true)
        }
    }
}
