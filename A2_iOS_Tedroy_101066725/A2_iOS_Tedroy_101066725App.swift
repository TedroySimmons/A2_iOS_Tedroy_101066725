//
//  A2_iOS_Tedroy_101066725App.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons on 2025-03-27.
//

import SwiftUI

@main
struct A2_iOS_Tedroy_101066725App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
