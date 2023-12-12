//
//  MovieListView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    @Binding var path: NavigationPath
    let movies: [Movie]

    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    HStack {
                        Text(movie.title)
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailsView(movie: movie, path: $path)
        }
    }

    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            movie.modelContext?.delete(movie)
        }
    }
}

#Preview {
    NavigationStack {
        MovieListView(path: .constant(.init()), movies: .init())
            .modelContainer(DataController.previewContainer)
    }
}
