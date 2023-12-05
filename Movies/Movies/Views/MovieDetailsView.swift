//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI
import SwiftData

struct MovieDetailsView: View {
    @Bindable var movie: Movie
    @Binding var path: NavigationPath
    var body: some View {
        Form {
            TextField("Title", text: $movie.title)
            TextField("Year", value: $movie.year, format: .number)
                .keyboardType(.numberPad)
        }
        .onSubmit {
            do {
                try movie.modelContext?.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
            path.removeLast()
        }
    }
}
