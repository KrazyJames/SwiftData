//
//  ContentView.swift
//  Rooms
//
//  Created by Jaime Escobar on 20/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var name: String = ""
    @State private var color: Color = .clear

    @Query private var rooms: [Room]

    private var isDisabled: Bool {
        name.trimmingCharacters(in: .whitespaces).isEmpty || color == .clear
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("New room") {
                    TextField("Room name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    ColorPicker("Pick your color", selection: $color, supportsOpacity: false)
                    VStack(alignment: .center) {
                        Button("Save") {
                            save()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isDisabled)
                    }
                    .frame(maxWidth: .infinity)
                }
                .listRowSeparator(.hidden)

                Section("Saved rooms") {
                    List {
                        ForEach(rooms) { room in
                            RoomRowView(room: room)
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Rooms")
        }
    }

    private func save() {
        let room = Room(name: name, color: UIColor(color))
        modelContext.insert(room)
        name = .init()
        color = .clear
    }

    private func delete(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(rooms[index])
        }
    }
}

struct RoomRowView: View {
    let room: Room
    var body: some View {
        HStack {
            Text(room.name)
            Spacer()
            Rectangle()
                .fill(Color(uiColor: room.color))
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}
