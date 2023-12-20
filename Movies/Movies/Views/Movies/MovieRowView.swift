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
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .bold()
            }
            Text(movie.reviewsCount)
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(movie.genre.description)
                .bold()
                .foregroundStyle(.background)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(Color.accentColor, in: .capsule)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let container = DataController.previewContainer
    let movie: Movie = try! container.mainContext.fetch(.init()).first!
    return MovieRowView(movie: movie)
        .padding()
}
