//
//  MockClientAPIManager.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 13/04/24.
//

import Foundation
class MockClientAPIManager: NetworkingService {
    private let urlSession = URLSession.shared
    var cachedUrl: URL?
    var task: URLSessionDataTask?
    func getDataWith(for URLEndPoint:String, parameters: [String: String], completionSuccess: @escaping (Data) -> Void, completionFailure: @escaping (APIError) -> Void) {
        if NetworkManager.isConnectedToNetwork() {
            if let url = Bundle.main.url(forResource: "MockProductList", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    if let _ = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                        completionSuccess(data)
                    }
                } catch let error {
                    
                    return completionFailure(.parsingError(error: error.localizedDescription))
                }
            }
        }
    }
}
