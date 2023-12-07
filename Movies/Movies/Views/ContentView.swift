//
//  ContentView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var moviesPath: NavigationPath = .init()
    @State private var actorsPath: NavigationPath = .init()
    var body: some View {
        TabView {
            NavigationStack(path: $moviesPath) {
                MoviesView(path: $moviesPath)
            }
            .tabItem {
                Label("Movies", systemImage: "film")
            }
            NavigationStack(path: $actorsPath) {
                ActorsListView()
            }
            .tabItem {
                Label("Actors", systemImage: "person.2")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: [Movie.self, Review.self, Actor.self],
            inMemory: true
        )
}
