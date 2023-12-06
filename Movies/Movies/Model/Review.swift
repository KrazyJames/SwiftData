//
//  Review.swift
//  Movies
//
//  Created by Jaime Escobar on 06/12/23.
//

import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var content: String
    var movie: Movie?

    init(subject: String, content: String, movie: Movie? = nil) {
        self.subject = subject
        self.content = content
        self.movie = movie
    }
}
