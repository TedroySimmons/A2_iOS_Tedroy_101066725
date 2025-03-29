//
//  ProductDetailView.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons
//

import SwiftUI

// Displays the information about a selected product
struct ProductDetailView: View {
    var product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Displays the product name with large bold font
            Text(product.name ?? "Unknown Product")
                .font(.largeTitle)
                .bold()
            
            // Displays the product description
            Text("Description: \(product.desc ?? "No description")")
                .font(.body)

            Text("Price: $\(product.price, specifier: "%.2f")")
                .font(.headline)

            Text("Provider: \(product.provider ?? "Unknown")")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Product Details")
    }
}
