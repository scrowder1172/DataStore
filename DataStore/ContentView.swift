//
//  ContentView.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PhotoObject.id) private var photos: [PhotoObject]
    
    var body: some View {
        NavigationStack {
            Button {
                do {
                    try modelContext.delete(model: PhotoObject.self)
                } catch {
                    print(error.localizedDescription)
                }
            } label: {
                Image(systemName: "trash")
                Text("Delete All Images")
            }
            .frame(width: 200, height: 40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            List(photos) { item in
                HStack {
                    Text(item.id, format: .number)
                    Text(item.title)
                    Spacer()
                }
                
                AsyncImage(url: URL(string: item.url)) { imagePhase in
                    switch imagePhase {
                    case .empty:
                        ContentUnavailableView("No Images Found", systemImage: "exclamationmark.triangle", description: Text("Please refresh the list to retrieve images."))
                    case .success(let image):
                        VStack(alignment: .leading){
                            Text("Album Cover")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                    case .failure(let error):
                        ContentUnavailableView("Image Not Available", systemImage: "antenna.radiowaves.left.and.right.slash", description: Text("The image URL could not be loaded."))
                    @unknown default:
                        ContentUnavailableView("Unknown Issue", systemImage: "exclamationmark.triangle", description: Text("An unknown problem prevented the image from being found."))
                    }
                }
            }
            .overlay {
                if photos.isEmpty {
                    ProgressView()
                }
            }
            .task {
                if photos.isEmpty {
                    await WebService().updateDataInDatabase(modelContext: modelContext)
                }
            }
            .refreshable {
                await WebService().updateDataInDatabase(modelContext: modelContext)
            }
            .navigationTitle("Photos")
        }
    }
}

#Preview {
    do {
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container: ModelContainer = try ModelContainer(for: PhotoObject.self, configurations: config)
        container.mainContext.insert(PhotoObject.SampleData)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create data model")
    }
}
