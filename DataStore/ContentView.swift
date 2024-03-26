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
    
    @State private var isDeletingAllItems: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HeaderButtonsView(isDeletingAllItems: $isDeletingAllItems)
                DataModelListView()
            }
            .navigationTitle("Data")
            .navigationDestination(for: DataModel.self) { data in
                DataNavDestinationView(data: data)
            }
            .alert("WARNING", isPresented: $isDeletingAllItems) {
                Button("OK", role: .destructive) {
                    do {
                        try modelContext.delete(model: DataModel.self)
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Do you want to delete all the data from DataModel?")
            }
            .onAppear {
                print(URL.applicationSupportDirectory.path(percentEncoded: false))
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DataModel.self, inMemory: true)
}
