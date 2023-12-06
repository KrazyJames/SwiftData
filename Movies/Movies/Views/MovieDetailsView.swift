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
            path.removeLast()
        }
        .sheet(isPresented: $showAddReviewView) {
            NavigationStack {
                AddReviewView(movie: movie)
            }
        }
    }
}

struct ReviewRowView: View {
    let subject: String
    let content: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(subject)
                .font(.headline)
            Text(content)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ReviewRowView(subject: "Some review", content: "Bla bla bla")
}
