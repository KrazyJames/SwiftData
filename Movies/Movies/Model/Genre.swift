//
//  Genre.swift
//  Movies
//
//  Created by Jaime Escobar on 19/12/23.
//

import Foundation


enum Genre: Int, Codable, CaseIterable, Identifiable {
    var id: Int {
        rawValue
    }
    case action = 1
    case horror
    case kids
    case fiction
    case romance
    case comedy
}

extension Genre: CustomStringConvertible {
    var description: String {
        switch self {
        case .action:
            "Action"
        case .horror:
            "Horror"
        case .kids:
            "Kids"
        case .fiction:
            "Fiction"
        case .romance:
            "Romance"
        case .comedy:
            "Comedy"
        }
    }
}
