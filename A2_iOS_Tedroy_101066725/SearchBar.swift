//
//  SearchBar.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons on 2025-03-27.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search by name or description...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}
