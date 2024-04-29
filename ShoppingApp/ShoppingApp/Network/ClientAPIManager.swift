//
//  ClientAPIManager.swift
//  ShoppingApp
//
//  Created by Nirav Hathi on 04/04/24.
//

import UIKit

enum APIError: Swift.Error {
    case objectWasUnexpectedlyDeallocated
    case failedToCreateURL
    case invalidResponse(response: URLResponse?)
    case networkError(error: String, response: URLResponse?)
    case parsingError(error: String)
}

class ClientAPIManager: NetworkingService {
    private let urlSession = URLSession.shared
    private var cachedUrl: URL?
    private var task: URLSessionDataTask?
    func getDataWith(for URLEndPoint:String, parameters: [String: String],  completionHandler:@escaping (Result<Data, APIError>) -> Void) {
        if NetworkManager.isConnectedToNetwork() {
            DispatchQueue.main.async {
                // indicator?.startAnimating()
            }
            guard let url = URL(
                string:URLEndPoint
                ) else {
                return completionHandler(.failure(.failedToCreateURL))
            }
            self.cachedUrl = url
            var components = URLComponents(string: url.absoluteString)!
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            
            task = urlSession.dataTask(with: components.url!) { (data, response, error) in
                DispatchQueue.main.async {
                    // indicator?.stopAnimating()
                }
                guard error == nil
                    else {
                        return completionHandler(.failure(.parsingError(error: error?.localizedDescription ?? "")))
                }
                guard let data = data
                    else {
                    return completionHandler(.failure(.parsingError(error: error?.localizedDescription ?? "There are no new Items to show")))
                }
                do {
                    if let _ = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                        completionHandler(.success(data))
                    }
                } catch let error {
                    
                    return completionHandler(.failure(.parsingError(error: error.localizedDescription)))
                }
            }
            task?.resume()
        } else {
            return completionHandler(.failure(.networkError(error:  "Internet not available.", response: nil)))
        }
    }
}
let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {
    
    var imageURL: URL?
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ url: URL) {
        
        // setup activityIndicator...
        activityIndicator.color = .darkGray
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageURL = url
        
        image = nil
        activityIndicator.startAnimating()
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
