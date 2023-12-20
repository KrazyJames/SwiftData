//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>
    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: systemImage(for: actor))
                Text(actor.name)
            }
            .onTapGesture {
                select(actor: actor)
            }
        }
    }

    private func systemImage(for actor: Actor) -> String {
        selectedActors.contains(actor) ? "checkmark.square" : "square"
    }

    private func select(actor: Actor) {
        if !selectedActors.contains(actor) {
            selectedActors.insert(actor)
        } else {
            selectedActors.remove(actor)
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    let descriptor = FetchDescriptor<Actor>()
    let actor = try? container
        .mainContext.fetch(descriptor).first!
    let selectedActors = Set<Actor>.init(arrayLiteral: actor!)
    return ActorSelectionView(selectedActors: .constant(selectedActors))
        .modelContainer(container)
}
