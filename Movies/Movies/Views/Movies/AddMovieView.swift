//
//  AddMovieView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

struct AddMovieView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title: String = .init()
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = .init()

    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && year != nil && !selectedActors.isEmpty
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
                .keyboardType(.numberPad)
            Section("Select actors") {
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    save()
                }
                .disabled(!isValid)
            }
        }
    }

    private func save() {
        guard let year, !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let newMovie = Movie(title: title, year: year)
        newMovie.actors = Array(selectedActors)
        selectedActors.forEach { actor in
            actor.movies.append(newMovie)
        }
        modelContext.insert(newMovie)
        do {
            try modelContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddMovieView()
            .modelContainer(DataController.previewContainer)
    }
}
