//
//  AddProductView.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool

    @State private var productID = ""
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product ID", text: $productID)
                    TextField("Product Name", text: $productName)
                    TextField("Description", text: $productDescription)
                    TextField("Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $productProvider)
                }

                Section {
                    Button("Save Product") {
                        addProduct()
                    }
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }

    private func addProduct() {
        guard let price = Double(productPrice), !productName.isEmpty, !productDescription.isEmpty, !productProvider.isEmpty else {
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = productName
        newProduct.desc = productDescription
        newProduct.price = price
        newProduct.provider = productProvider

        do {
            try viewContext.save()
            isPresented = false
        } catch {
            print("Failed to save product: \(error.localizedDescription)")
        }
    }
}
