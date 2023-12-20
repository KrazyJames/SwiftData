//
//  Movie.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var year: Int
    var genre: Genre

    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review]
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor]

    init(
        title: String,
        year: Int,
        reviews: [Review] = .init(),
        actors: [Actor] = .init(),
        genre: Genre
    ) {
        self.title = title
        self.year = year
        self.reviews = reviews
        self.actors = actors
        self.genre = genre
    }
}

extension Movie {
    var reviewsCount: String {
        guard !reviews.isEmpty else {
            return "No reviews"
        }
        let count = reviews.count
        return if count > 1 {
            "\(count) reviews"
        } else {
            "1 review"
        }
    }
}
