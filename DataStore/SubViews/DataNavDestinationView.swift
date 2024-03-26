//
//  DataNavDestinationView.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import SwiftData
import SwiftUI

struct DataNavDestinationView: View {
    
    let data: DataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(data.text)
                    .font(.title)
                Spacer()
            }
            .padding(.leading)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
            
            HStack{
                Text("Priority: \(data.priority)")
                    .font(.headline)
                Spacer()
            }
            .frame(height: 30)
            .padding(.leading)
            .foregroundStyle(.white)
            .background(data.priority < 20 ? .red : .green)
            .clipShape(.rect(cornerRadius: 10))
            
            HStack{
                Text("ID: \(data.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .frame(height: 20)
            .padding(.leading)
            .background(.secondary.opacity(0.3))
            .clipShape(.rect(cornerRadius: 10))
            Spacer()
        }
        .padding(.horizontal)
    }
}


#Preview {
    do {
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container: ModelContainer = try ModelContainer(for: DataModel.self, configurations: config)
        
        return DataNavDestinationView(data: .SampleData)
                .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
