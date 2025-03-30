//
//  ContentView.swift
//  Paws
//
//  Created by Aran Fononi on 31/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var pets: [Pet]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                EmptyView()
            } // ScrollView
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(icon: "cat.circle", title: "No Pets", description: "Add a new pet to get started.")
                }
            }
        } // Navigation Stack
    }
}

#Preview("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
