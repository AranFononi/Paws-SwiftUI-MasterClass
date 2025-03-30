//
//  EditPetView.swift
//  Paws
//
//  Created by Aran Fononi on 31/3/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            // MARK: - Image
            if let imageData = pet.photo {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth: 0 , maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            } else {
                CustomContentUnavailableView(icon: "pawprint.circle", title: "No Photo", description: "Add a photo of your favorite pet to make it easier to find them")
                    .padding(.top)
            }
            
            // MARK: - Photo Picker
            PhotosPicker(selection: $photosPickerItem) {
                Label("Select a photo", systemImage: "photo.badge.plus")
                    .frame(minWidth:0 , maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            
            // MARK: - Text Field
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            
            // MARK: - Button
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .padding(8)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
            
            
        } // Form
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: photosPickerItem) {
            Task {
                pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    NavigationStack{
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Pet.self, configurations: configuration)
            let sampleData = Pet(name: "Daisey")
            
            return EditPetView(pet: sampleData)
        } catch {
            fatalError("Could not load preview data. \(error.localizedDescription) ")
        }
    }}
