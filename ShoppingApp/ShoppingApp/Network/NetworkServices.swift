//
//  NetworkServices.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 13/04/24.
//

import Foundation
protocol NetworkingService {
    func getDataWith(for URLEndPoint:String, parameters: [String: String],  completionHandler:@escaping (Result<Data, APIError>) -> Void)
}
