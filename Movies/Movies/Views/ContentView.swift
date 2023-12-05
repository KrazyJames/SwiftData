//
//  ContentView.swift
//  Movies
//
//  Created by Jaime Escobar on 05/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var path: NavigationPath = .init()
    var body: some View {
        NavigationStack(path: $path) {
            MoviesView(path: $path)
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
