//
//  ActorDetailsView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct ActorDetailsView: View {
    @Bindable var actor: Actor
    @State private var selectedMovies: Set<Movie> = .init()

    var body: some View {
        MovieSelectionView(selectedMovies: $selectedMovies)
        .navigationTitle(actor.name)
        .onAppear {
            selectedMovies = Set(actor.movies)
        }
        .onChange(of: selectedMovies) { oldValue, newValue in
            actor.movies = Array(newValue)
            do {
                try actor.modelContext?.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    let descriptor = FetchDescriptor<Actor>()
    let actor = try? container.mainContext.fetch(descriptor).first!
    return NavigationStack {
        ActorDetailsView(actor: actor!)
            .modelContainer(container)
    }
}
