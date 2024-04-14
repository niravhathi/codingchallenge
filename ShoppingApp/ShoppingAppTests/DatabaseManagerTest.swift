//
//  DatabaseManagerTest.swift
//  ShoppingAppTests
//
//  Created by Nirav Hathi on 14/04/24.
//

import XCTest
import CoreData
@testable import ShoppingApp
final class DatabaseManagerTest: XCTestCase {
    
    var mockStorageManager: DatabaseManager!
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingApp", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    override func setUp() {
       initStubs()
        mockStorageManager = DatabaseManager(container: mockPersistantContainer)
        
        //Listen to the change in context
       // NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddProduct() {
        // Given
       let product =  Product(id: 7, title: "Samsung Galaxy Book", description: "Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched", price: 1499, discountPercentage: 4.15, rating: 4.25, stock: 50, brand: "Samsung", category: "laptops", thumbnail: "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg", images: [
        "https://cdn.dummyjson.com/product-images/7/1.jpg",
        "https://cdn.dummyjson.com/product-images/7/2.jpg",
        "https://cdn.dummyjson.com/product-images/7/3.jpg",
        "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg"
      ], quantity: 2)
        // When
        let products: () =  mockStorageManager.addProduct(product: product)
        
        // Then
        XCTAssertNotNil(products)
    }
    func testRemoveFromName() {
        testAddProduct()
        let cartData = mockStorageManager.prepareData()
        let countCartData = cartData.count
        mockStorageManager.removeFromName(stringName: "Samsung Galaxy Book")
        XCTAssertEqual(countCartData, mockStorageManager.prepareData().count + 1)
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension DatabaseManagerTest {
    //MARK: Creat some fakes
    func initStubs() {
        
        let product =  Product(id: 8, title: "Microsoft Surface Laptop 4", description: "Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen.", price: 1499, discountPercentage: 4.43, rating: 4.3, stock: 68, brand: "Microsoft Surface", category: "laptops", thumbnail: "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/8/1.jpg",
            "https://cdn.dummyjson.com/product-images/8/2.jpg",
            "https://cdn.dummyjson.com/product-images/8/3.jpg",
            "https://cdn.dummyjson.com/product-images/8/4.jpg",
            "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg"
          ], quantity: nil)
        let product2 =  Product(id: 9, title: "Infinix INBOOK", description: "Infinix Inbook X1 Ci3 10th 8GB 256GB 14 Win10 Grey – 1 Year Warranty", price: 1099, discountPercentage: 11.83, rating: 4.54, stock: 96, brand: "Infinix", category: "laptops", thumbnail: "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg", images: [
            "https://cdn.dummyjson.com/product-images/9/1.jpg",
            "https://cdn.dummyjson.com/product-images/9/2.png",
            "https://cdn.dummyjson.com/product-images/9/3.png",
            "https://cdn.dummyjson.com/product-images/9/4.jpg",
            "https://cdn.dummyjson.com/product-images/9/thumbnail.jpg"
          ], quantity: nil)
        _ = insert(product: product)
        _ = insert(product: product2)
        
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    func  insert(product: Product) -> CartData? {
        
        let obj = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: mockPersistantContainer.viewContext) 
        obj.setValue(product.brand, forKey: "brand")
        obj.setValue(product.price, forKey: "price")
        obj.setValue(product.title, forKey: "title")
        return obj as? CartData
    }
    func clearData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "CartData")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        
        try! mockPersistantContainer.viewContext.save()
    }
}
