//
//  MovieRowView.swift
//  Movies
//
//  Created by Jaime Escobar on 14/12/23.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.year.description)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .bold()
            }
            Text(movie.reviewsCount)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let container = DataController.previewContainer
    let movie: Movie = try! container.mainContext.fetch(.init()).first!
    return MovieRowView(movie: movie)
        .padding()
}
