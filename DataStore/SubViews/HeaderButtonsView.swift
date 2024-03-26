//
//  HeaderButtonsView.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import SwiftData
import SwiftUI

struct HeaderButtonsView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Binding var isDeletingAllItems: Bool
    
    var body: some View {
        HStack {
            Button {
                for _ in 1...10 {
                    let newDataToAdd: DataModel = DataModel(text: "Task \(Int.random(in: 0...10))", priority: Int.random(in: 0...100))
                    modelContext.insert(newDataToAdd)
                }
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.small)
                Text("Load Sample Data")
                    .font(.caption)
            }
            .frame(width: 150, height: 40)
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            Button {
                isDeletingAllItems = true
            } label: {
                Image(systemName: "trash")
                    .imageScale(.small)
                Text("Delete All Data")
                    .font(.caption)
            }
            .frame(width: 150, height: 40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.capsule)
        }
    }
}

#Preview {
    do {
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container: ModelContainer = try ModelContainer(for: DataModel.self, configurations: config)
        
        return HeaderButtonsView(isDeletingAllItems: .constant(false))
                .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
