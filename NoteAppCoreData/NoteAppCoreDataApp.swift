//
//  NoteAppCoreDataApp.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//

import SwiftUI

@main
struct NoteAppCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
