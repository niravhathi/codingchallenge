//
//  MockClientAPIManager.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 13/04/24.
//

import Foundation
class MockClientAPIManager: NetworkingService {
    func getDataWith(for URLEndPoint:String, parameters: [String: String],  completionHandler:@escaping (Result<Data, APIError>) -> Void) {
        if NetworkManager.isConnectedToNetwork() {
            if let url = Bundle.main.url(forResource: Constant.mockProductList, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    if let _ = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                        completionHandler(.success(data))
                    }
                } catch let error {
                    
                    return completionHandler(.failure(.parsingError(error: error.localizedDescription)))
                }
            }
        }
    }
}
