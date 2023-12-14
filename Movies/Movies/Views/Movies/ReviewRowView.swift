//
//  ReviewRowView.swift
//  Movies
//
//  Created by Jaime Escobar on 14/12/23.
//

import SwiftUI
import SwiftData

struct ReviewRowView: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading) {
            Text(review.subject)
                .font(.headline)
            Text(review.content)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let container = DataController.previewContainer
    let review: Review = try! container.mainContext.fetch(.init()).first!
    return ReviewRowView(review: review)
        .padding()
}
