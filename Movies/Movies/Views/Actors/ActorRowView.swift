//
//  ActorRowView.swift
//  Movies
//
//  Created by Jaime Escobar on 14/12/23.
//

import SwiftUI
import SwiftData

struct ActorRowView: View {
    let actor: Actor

    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
                .font(.headline)
                .bold()
            Text(actor.appearsIn)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let container = DataController.previewContainer
    let actor: Actor = try! container.mainContext.fetch(.init()).first!
    return ActorRowView(actor: actor)
        .padding()
}
