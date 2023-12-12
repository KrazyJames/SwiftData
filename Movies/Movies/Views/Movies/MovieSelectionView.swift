//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie>
    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: systemImage(for: movie))
                Text(movie.title)
            }
            .onTapGesture {
                select(movie: movie)
            }
        }
    }

    private func systemImage(for movie: Movie) -> String {
        selectedMovies.contains(movie) ? "checkmark.square" : "square"
    }

    private func select(movie: Movie) {
        if !selectedMovies.contains(movie) {
            selectedMovies.insert(movie)
        } else {
            selectedMovies.remove(movie)
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    let descriptor = FetchDescriptor<Movie>()
    let movie = try? container
        .mainContext.fetch(descriptor).first!
    let selectedMovies = Set<Movie>.init(arrayLiteral: movie!)
    return MovieSelectionView(selectedMovies: .constant(.init(selectedMovies)))
        .modelContainer(container)
}
