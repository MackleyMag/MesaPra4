//
//  MesaPra4App.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 28/06/24.
//

import SwiftUI
import SwiftData

@main
struct MesaPra4App: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            DiningTableListView()
        }.modelContainer(container)
    }
    
    init() {
        let schema = Schema([DiningTable.self])
        let config = ModelConfiguration("PlayingWithSwiftData", schema: schema)
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
    }
}
