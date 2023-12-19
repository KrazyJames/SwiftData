//
//  MovieSchemaVersions.swift
//  Movies
//
//  Created by Jaime Escobar on 15/12/23.
//

import Foundation
import SwiftData

// MARK: - V1
enum MovieSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    static var versionIdentifier: Schema.Version = .init(1, 0, 0)

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

// MARK: - V2
enum MovieSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    static var versionIdentifier: Schema.Version = .init(2, 0, 0)

    @Model
    final class Movie {
        @Attribute(.unique)
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
}


// MARK: - V3
enum MovieSchemaV3: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    static var versionIdentifier: Schema.Version = .init(3, 0, 0)

    @Model
    final class Movie {
        @Attribute(.unique, originalName: "title")
        var name: String
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
            self.name = title
            self.year = year
            self.reviews = reviews
            self.actors = actors
        }
    }
}

extension MovieSchemaV3.Movie {
    var title: String {
        set {
            name = newValue
        }
        get {
            name
        }
    }
}
