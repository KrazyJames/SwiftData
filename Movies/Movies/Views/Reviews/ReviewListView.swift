//
//  ReviewListView.swift
//  Movies
//
//  Created by Jaime Escobar on 06/12/23.
//

import SwiftUI
import SwiftData

struct ReviewListView: View {
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
                let review = reviews.remove(at: index)
                review.modelContext?.delete(review)
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: .constant(.init()))
}
