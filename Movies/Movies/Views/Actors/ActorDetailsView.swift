//
//  ActorDetailsView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct ActorDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var actor: Actor
    @State private var selectedMovies: Set<Movie> = .init()

    var body: some View {
        VStack {
            Text(actor.name)
            MovieSelectionView(selectedMovies: $selectedMovies)
        }
        .navigationTitle(actor.name)
        .onAppear {
            selectedMovies = Set(actor.movies)
        }
        .onChange(of: selectedMovies) { oldValue, newValue in
            actor.movies = Array(newValue)
            do {
                try modelContext.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
