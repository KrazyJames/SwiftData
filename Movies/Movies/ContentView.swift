//
//  ContentView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            AddMovieView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: [Movie.self],
            inMemory: true
        )
}
