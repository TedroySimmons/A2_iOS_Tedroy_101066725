//
//  A2_iOS_Tedroy_101066725App.swift
//  A2_iOS_Tedroy_101066725
//
//  Created by Tedroy Simmons
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
