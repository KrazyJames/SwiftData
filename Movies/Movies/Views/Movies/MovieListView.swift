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
    @Binding var filterOption: FilterOption
    let movies: [Movie]

    private var isFiltering: Bool {
        filterOption != .none
    }
    private var filteredMovies: [Movie] {
        movies.filter(filter)
    }

    var body: some View {
        List {
            Section {
                ForEach(filteredMovies) { movie in
                    NavigationLink(value: movie) {
                        MovieRowView(movie: movie)
                    }
                }
                .onDelete(perform: delete)
            } header: {
                if isFiltering {
                    HStack {
                        Spacer()
                        Button("Clear filter") {
                            filterOption = .none
                        }
                    }
                }
            }
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

    private func filter(from movie: Movie) -> Bool {
        switch filterOption {
        case .none:
            return true
        case .title(let title):
            guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return true
            }
            return movie.title.lowercased().contains(title.lowercased())
        case .reviews(count: let count):
            return movie.reviews.count >= count
        case .actors(count: let count):
            return movie.actors.count >= count
        }
    }

}

#Preview {
    let container = DataController.previewContainer
    let movieDescriptor = FetchDescriptor<Movie>()
    let movies = try! container.mainContext.fetch(movieDescriptor)
    return NavigationStack {
        MovieListView(path: .constant(.init()), filterOption: .constant(.actors(count: .zero)), movies: movies)
            .modelContainer(container)
    }
}
