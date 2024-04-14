

import Foundation
import UIKit
import CoreData

class DatabaseManager : StorageManager {
    
    var cartData: [Product] = []
    //MARK: Function
    private func fetchProduct() -> [CartData] {
        let request: NSFetchRequest<CartData> = CartData.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [CartData]()
    }
    
    func addProduct(product: Product) {
        let fetchRequest: NSFetchRequest<CartData> = CartData.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "name==%@",product.title ?? "")
        let objects = try! backgroundContext.fetch(fetchRequest)
        if objects.count == 1 {
            objects[0].quantity += 1
            self.save()
        } else {
            guard let CartData = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: backgroundContext) as? CartData else { return  }
            CartData.name = product.title
            CartData.img = product.thumbnail
            CartData.price = Double(product.price ?? Int(0.0))
            CartData.quantity = 1
            CartData.brand = product.brand
            self.save()
        }
    }
    func removeFromName(stringName: String) {
        let fetchRequest: NSFetchRequest<CartData> = CartData.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "name==%@",stringName)
        let objects = try! backgroundContext.fetch(fetchRequest)
        for obj in objects {
            backgroundContext.delete(obj)
        }

        do {
            try backgroundContext.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        self.save()
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    func prepareData() -> [Product] {
        let getData = self.fetchProduct()
        cartData = []
        getData.forEach({ data in
            cartData.append( Product(id: Int(bitPattern: data.id), title: data.name ?? "", description: data.description, price: Int(data.price), discountPercentage: 0.0, rating: 0.0, stock: 0, brand: data.brand ?? "", category: "", thumbnail: data.img ?? "", images: [], quantity: Int(data.quantity) ))
        })
        return cartData
    }
}
