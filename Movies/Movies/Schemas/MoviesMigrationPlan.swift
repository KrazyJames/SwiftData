//
//  MoviesMigrationPlan.swift
//  Movies
//
//  Created by Jaime Escobar on 19/12/23.
//

import Foundation
import SwiftData


enum MoviesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [MovieSchemaV1.self,
         MovieSchemaV2.self,
         MovieSchemaV3.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
    }
    
    // MARK: - Custom Migration
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: MovieSchemaV1.self,
        toVersion: MovieSchemaV2.self
    ) { context in
        guard let movies: [Movie] = try? context.fetch(.init()) else { return }
        var duplicates = Set<Movie>()
        var uniqueSet = Set<String>()
        for movie in movies {
            if !uniqueSet.insert(movie.title).inserted {
                duplicates.insert(movie)
            }
        }

        for duplicate in duplicates {
            guard let movieToUpdate = movies.first(where: { $0.id == duplicate.id }) else { continue }
            movieToUpdate.title = movieToUpdate.title.appending(" \(movieToUpdate.id)")

        }
        try? context.save()
    } didMigrate: { context in
        return
    }

    // MARK: - Lightweight Migration
    static let migrateV2toV3 = MigrationStage.lightweight(
        fromVersion: MovieSchemaV2.self,
        toVersion: MovieSchemaV3.self
    )

}
