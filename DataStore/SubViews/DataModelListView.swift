//
//  DataModelListView.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import SwiftData
import SwiftUI

struct DataModelListView: View {
    
    @Query(filter: #Predicate<DataModel> { $0.priority < 50 }, sort: \DataModel.priority) private var dataModel: [DataModel]
    
    var body: some View {
        List(dataModel) { data in
            NavigationLink(value: data) {
                HStack{
                    Text("\(data.priority)")
                        .font(.headline)
                        .frame(width: 30, height: 30)
                        .background(data.priority < 20 ? .red : .blue)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        }
                    Text(data.text)
                }
            }
        }
    }
}


#Preview {
    do {
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container: ModelContainer = try ModelContainer(for: DataModel.self, configurations: config)
        
        container.mainContext.insert(DataModel.SampleData)
        
        return NavigationStack{
            DataModelListView()
                .modelContainer(container)
                .navigationDestination(for: DataModel.self) { data in
                    DataNavDestinationView(data: data)
                }
                .navigationTitle("Sample Data")
        }
    } catch {
        fatalError("Failed to create model container")
    }
}
