//
//  Actor.swift
//  Movies
//
//  Created by Jaime Escobar on 07/12/23.
//

import Foundation
import SwiftData


@Model
final class Actor {
    var name: String
    var movies: [Movie]

    init(name: String, movies: [Movie] = .init()) {
        self.name = name
        self.movies = movies
    }
}
