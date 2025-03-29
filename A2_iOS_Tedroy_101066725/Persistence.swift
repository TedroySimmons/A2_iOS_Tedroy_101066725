//
//  Persistence.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons on 2025-03-27.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Tedroy_101066725")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        // Ensure Default Products are Always Present
        addDefaultProducts()
    }

    private func addDefaultProducts() {
        let context = container.viewContext

        // Check if the default products already exist to avoid duplicates
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            if count >= 10 { return } 
        } catch {
            print("Failed to fetch products: \(error.localizedDescription)")
        }

        // Default Household Products
        let defaultProducts: [(String, String, String, Double, String)] = [
            ("P001", "Vacuum Cleaner", "Powerful suction for home cleaning", 199.99, "Dyson"),
            ("P002", "Microwave Oven", "High-speed heating and cooking", 129.99, "Samsung"),
            ("P003", "Refrigerator", "Energy-efficient cooling system", 899.99, "LG"),
            ("P004", "Dishwasher", "Quiet and effective dish cleaning", 499.99, "Bosch"),
            ("P005", "Washing Machine", "Top-loading, high-efficiency", 699.99, "Whirlpool"),
            ("P006", "Air Purifier", "Removes allergens and pollutants", 249.99, "Philips"),
            ("P007", "Coffee Maker", "Brews fresh coffee quickly", 79.99, "Nespresso"),
            ("P008", "Blender", "High-speed blending for smoothies", 59.99, "NutriBullet"),
            ("P009", "Toaster", "2-slice toaster with adjustable settings", 39.99, "Cuisinart"),
            ("P010", "Iron", "Steam iron for wrinkle-free clothes", 49.99, "Rowenta")
        ]

        // Insert Default Products
        for (_, name, desc, price, provider) in defaultProducts {
            let newProduct = Product(context: context)
            newProduct.id = UUID()
            newProduct.name = name
            newProduct.desc = desc
            newProduct.price = price
            newProduct.provider = provider
        }

        do {
            try context.save()
        } catch {
            print("Failed to save default products: \(error.localizedDescription)")
        }
    }
}
