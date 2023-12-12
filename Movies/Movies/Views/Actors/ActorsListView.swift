//
//  ActorsListView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct ActorsListView: View {
    @Query(sort: \Actor.name) var actors: [Actor]
    @State private var isAddActorPresented = false
    
    var body: some View {
        List(actors) { actor in
            NavigationLink(value: actor) {
                Text(actor.name)
            }
        }
        .navigationTitle("Actors")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add actor") {
                    isAddActorPresented.toggle()
                }
            }
        }
        .navigationDestination(for: Actor.self) { actor in
            ActorDetailsView(actor: actor)
        }
        .sheet(isPresented: $isAddActorPresented) {
            AddActorView()
                .presentationDetents([.fraction(1/4)])
        }
    }
}

#Preview {
    NavigationStack {
        ActorsListView()
            .modelContainer(DataController.previewContainer)
    }
}
