//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Walter Bernal Montero on 6/11/24.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
