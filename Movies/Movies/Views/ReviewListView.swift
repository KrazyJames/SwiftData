//
//  ReviewListView.swift
//  Movies
//
//  Created by Jaime Escobar on 06/12/23.
//

import SwiftUI
import SwiftData

struct ReviewListView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var reviews: [Review]
    var body: some View {
        List {
            ForEach(reviews) { review in
                ReviewRowView(subject: review.subject, content: review.content)
            }
            .onDelete(perform: deleteReviews)
        }
    }

    private func deleteReviews(at indexSet: IndexSet) {
        indexSet.forEach { index in
            withAnimation {
                modelContext.delete(reviews.remove(at: index))
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: .constant(.init()))
        .modelContainer(for: [Review.self], inMemory: true)
}
