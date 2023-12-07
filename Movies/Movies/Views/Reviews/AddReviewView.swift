//
//  AddReviewView.swift
//  Movies
//
//  Created by Jaime Escobar on 06/12/23.
//

import SwiftUI
import SwiftData

struct AddReviewView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var subject: String = .init()
    @State private var content: String = .init()
    let movie: Movie?

    private var isValid: Bool {
        !subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        Form {
            TextField("Subject", text: $subject)
            TextField("Body", text: $content)
        }
        .navigationTitle("Add review")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    saveReview()
                }
                .disabled(!isValid)
            }
        }
    }

    private func saveReview() {
        let review = Review(subject: subject, content: content, movie: movie)
        modelContext.insert(review)
        movie?.reviews.append(review)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddReviewView(movie: nil)
            .modelContainer(for: [Movie.self, Review.self], inMemory: true)
    }
}
