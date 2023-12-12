//
//  AddActorView.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import SwiftUI
import SwiftData

struct AddActorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name: String = .init()
    var body: some View {
        NavigationStack {
            Form {
                TextField("Actor name", text: $name)
            }
            .navigationTitle("New actor")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveActor()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveActor() {
        let actor = Actor(name: name)
        modelContext.insert(actor)
        dismiss()
    }
}

#Preview {
    AddActorView()
        .modelContainer(DataController.previewContainer)
}
