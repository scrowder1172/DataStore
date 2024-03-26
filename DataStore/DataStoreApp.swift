//
//  DataStoreApp.swift
//  DataStore
//
//  Created by SCOTT CROWDER on 3/26/24.
//

import SwiftData
import SwiftUI

@main
struct DataStoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PhotoObject.self)
    }
}
