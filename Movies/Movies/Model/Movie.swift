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
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review]
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor]

    init(
        title: String,
        year: Int,
        reviews: [Review] = .init(),
        actors: [Actor] = .init()
    ) {
        self.title = title
        self.year = year
        self.reviews = reviews
        self.actors = actors
    }
}
