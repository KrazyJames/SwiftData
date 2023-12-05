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

    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && year != nil
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
                .keyboardType(.numberPad)
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
            .modelContainer(
                for: [Movie.self],
                inMemory: true
            )
    }
}
