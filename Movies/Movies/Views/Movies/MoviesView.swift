//
//  MoviesView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    case addMovie
    case showFilter

    var id: Int {
        hashValue
    }
}

struct MoviesView: View {
    @Binding var path: NavigationPath

    @Query(sort: \Movie.title) private var movies: [Movie]
    @State private var presentedSheet: Sheets?
    @State private var filterOption: FilterOption = .none

    var body: some View {
        MovieListView(
            path: $path,
            filterOption: $filterOption,
            movies: movies
        )
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    presentedSheet = .addMovie
                } label: {
                    Label("Add movie", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigation) {
                Button {
                    presentedSheet = .showFilter
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .sheet(item: $presentedSheet, content: sheetView)
    }

    @ViewBuilder
    private func sheetView(from sheet: Sheets) -> some View {
        switch sheet {
        case .addMovie:
            NavigationStack {
                AddMovieView()
            }
        case .showFilter:
            NavigationStack {
                FilterView(filterOption: $filterOption)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MoviesView(path: .constant(.init()))
            .modelContainer(DataController.previewContainer)
    }
}
