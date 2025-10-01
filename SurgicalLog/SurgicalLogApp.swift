//
//  SurgicalLogApp.swift
//  SurgicalLog
//
//  Created by Ichida Ko on 2025/07/16.
//

import SwiftUI
import SwiftData

@main
struct SurgicalLogApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SurgicalRecord.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
