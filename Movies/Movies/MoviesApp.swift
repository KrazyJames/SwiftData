//
//  MoviesApp.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}

@MainActor
final class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Movie.self, Review.self, Actor.self, configurations: config)

            let movie1 = Movie(title: "Avengers Endgame", year: 2014)
            let movie2 = Movie(title: "Deadpool 2", year: 2018)

            let actor1 = Actor(name: "Tom Holland")
            let actor2 = Actor(name: "Ryan Reynolds")
            let actor3 = Actor(name: "Josh Brolin")

            [actor1, actor2, actor3].forEach { actor in
                container.mainContext.insert(actor)
            }

            movie1.actors = [actor1, actor3]
            movie2.actors = [actor2, actor3]

            let review1 = Review(subject: "Amazing", content: "Best final ever")
            let review2 = Review(subject: "Hilarious", content: "Cant stop laughing")
            let review3 = Review(subject: "Cried at the end", content: "I was moved bc the end")

            [review1, review2, review3].forEach { review in
                container.mainContext.insert(review)
            }

            movie1.reviews = [review1, review3]
            movie2.reviews = [review2]

            container.mainContext.insert(movie1)
            container.mainContext.insert(movie2)
            
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
