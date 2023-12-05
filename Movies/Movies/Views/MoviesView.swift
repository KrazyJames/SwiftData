//
//  MoviesView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

struct MoviesView: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @State private var isAddMoviePresented = false

    var body: some View {
        MovieListView(movies: movies)
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add movie") {
                    isAddMoviePresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isAddMoviePresented) {
            NavigationStack {
                AddMovieView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MoviesView()
            .modelContainer(
                for: [Movie.self],
                inMemory: true
            )
    }
}
