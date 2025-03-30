//
//  Pet.swift
//  Paws
//
//  Created by Aran Fononi on 31/3/25.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configutation = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configutation)
        
        
        container.mainContext.insert(Pet(name: "Rexy"))
        container.mainContext.insert(Pet(name: "Lia"))
        container.mainContext.insert(Pet(name: "Leo"))
        container.mainContext.insert(Pet(name: "Mia"))
        container.mainContext.insert(Pet(name: "Mini"))
        container.mainContext.insert(Pet(name: "Lala"))
        container.mainContext.insert(Pet(name: "Sofi"))
        container.mainContext.insert(Pet(name: "Prince"))
        
        return container
    }
}
