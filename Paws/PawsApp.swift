//
//  PawsApp.swift
//  Paws
//
//  Created by Aran Fononi on 31/3/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
