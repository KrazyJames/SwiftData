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
    @State private var showAddReviewView = false

    var body: some View {
        Form {
            TextField("Title", text: $movie.title)
            TextField("Year", value: $movie.year, format: .number)
                .keyboardType(.numberPad)

            Section("Actors") {
                List(movie.actors) { actor in
                    Text(actor.name)
                }
            }

            Section("Reviews") {
                Button("Add review") {
                    showAddReviewView.toggle()
                }
                if movie.reviews.isEmpty {
                    ContentUnavailableView("No reviews", systemImage: "tray.fill")
                } else {
                    ReviewListView(reviews: $movie.reviews)
                }
            }
        }
        .onSubmit {
            do {
                try movie.modelContext?.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        .sheet(isPresented: $showAddReviewView) {
            NavigationStack {
                AddReviewView(movie: movie)
            }
        }
    }
}


#Preview {
    let container = DataController.previewContainer
    let descriptor = FetchDescriptor<Movie>.init()
    let movie = try? container.mainContext.fetch(descriptor).first
    return MovieDetailsView(movie: movie!, path: .constant(.init()))
}
