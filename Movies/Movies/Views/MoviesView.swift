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
    @Binding var path: NavigationPath

    var body: some View {
        MovieListView(path: $path, movies: movies)
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
        MoviesView(path: .constant(.init()))
            .modelContainer(
                for: [Movie.self],
                inMemory: true
            )
    }
}
