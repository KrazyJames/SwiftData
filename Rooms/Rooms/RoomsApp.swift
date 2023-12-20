//
//  RoomsApp.swift
//  Rooms
//
//  Created by Jaime Escobar on 20/12/23.
//

import SwiftUI
import SwiftData

@main
struct RoomsApp: App {

    // MARK: - Register Value Transformer
    init() {
        ValueTransformer.setValueTransformer(
            UIColorTransformer(),
            forName: .init("UIColorTransformer")
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(
                    for: [Room.self]
                )
        }
    }
}

@MainActor
final class DataController {
    static var previewContainer: ModelContainer {
        do {
            let container = try ModelContainer(
                for: Room.self,
                configurations: ModelConfiguration(
                    isStoredInMemoryOnly: true
                )
            )
            let room = Room(
                name: "Kitchen",
                color: .red
            )
            container.mainContext.insert(room)
            return container
        } catch {
            fatalError(error.localizedDescription)
        }

    }
}
