//
//  DataModel.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import Foundation
import SwiftData

@Model
final class DataModel {
    @Attribute(.unique)
    let id: UUID = UUID()
    let text: String
    let priority: Int
    
    init(text: String, priority: Int) {
        self.text = text
        self.priority = priority
    }
    
    static let SampleData: DataModel = DataModel(text: "Sample data", priority: 1)
}
