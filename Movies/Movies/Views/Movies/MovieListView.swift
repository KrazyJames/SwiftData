//
//  MovieListView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    @Environment(\.modelContext) private var modelContext
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
            modelContext.delete(movie)
            do {
                try modelContext.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieListView(path: .constant(.init()), movies: .init())
            .modelContainer(
                for: [Movie.self],
                inMemory: true
            )
    }
}
