//
//  ContentView.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Get the products frome core data, sorted alphabetically by name
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @State private var searchText = ""
    @State private var isAddingProduct = false

    var body: some View {
        NavigationView {
            VStack {
                // Search bar for products
                SearchBar(text: $searchText)
                
                // List of products that are filtered based on the search text
                List {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack(alignment: .leading) {
                                // Display product name
                                Text(product.name ?? "Unknown")
                                    .font(.headline)
                                // Display product description
                                Text(product.desc ?? "No description")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    // Swipe to delete
                    .onDelete(perform: deleteProduct)
                }
                .listStyle(PlainListStyle())

                Spacer()
            }
            .navigationTitle("Products")
            .toolbar {
                // Add button in navigation bar to open the add product sheet
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingProduct = true }) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingProduct) {
                AddProductView(isPresented: $isAddingProduct)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
    // Filters products based on search trext
    private var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.name?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.desc?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}
