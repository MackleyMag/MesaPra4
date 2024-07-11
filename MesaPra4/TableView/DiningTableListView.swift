//
//  ContentView.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 28/06/24.
//

import SwiftUI
import SwiftData

struct DiningTableListView: View {
    @State private var createNewTable = false
    
    var body: some View {
        NavigationStack {
            DiningTableListComponent()
            .navigationTitle("Minhas Mesas")
            .toolbar {
                NavigationLink {
                    NewDiningTableView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer(DiningTable.self)
    let dTables = DiningTable.samplesDiningTable
    preview.addExamples(dTables)
    return DiningTableListView()
        .modelContainer(preview.container)
}
