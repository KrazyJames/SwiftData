//
//  FilterView.swift
//  Movies
//
//  Created by Jaime Escobar on 14/12/23.
//

import SwiftUI

enum FilterOption: Equatable {
    case none
    case title(String)
    case reviews(count: Int)
    case actors(count: Int)
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var filterOption: FilterOption

    @State private var title: String = .init()
    @State private var reviews: Int = .zero
    @State private var actors: Int = .zero

    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $title)
                Button("Search") {
                    filterOption = .title(title)
                    dismiss()
                }
            }
            Section("Filter by reviews") {
                Stepper("More than \(reviews) reviews", value: $reviews, in: 0...100)
                Button("Search") {
                    filterOption = .reviews(count: reviews)
                    dismiss()
                }
                .disabled(reviews < .zero)
            }

            Section("Filter by number of actors") {
                Stepper("More than \(actors) actors", value: $actors, in: 0...100)
                Button("Search") {
                    filterOption = .actors(count: actors)
                    dismiss()
                }
                .disabled(actors < .zero)
            }
        }
    }
}

#Preview {
    FilterView(filterOption: .constant(.title("Spiderman")))
}
