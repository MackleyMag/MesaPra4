//
//  DinningTableListComponent.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 28/06/24.
//

import SwiftUI
import SwiftData

struct DiningTableListComponent: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DiningTable.dateAdded, order: .reverse) private var diningTables: [DiningTable]
    
    var body: some View {
        Group {
            if diningTables.isEmpty {
                ContentUnavailableView("Você ainda não registrou nenhuma mesa. Crie uma agora par controlar sua conta 😉", systemImage: "menucard")
            } else {
                List {
                    ForEach(diningTables) { diningTable in
                        NavigationLink {
                            OpenDiningTable(diningTable: diningTable)
                        } label: {
                            DiningTableListItem(dTable: diningTable)
                        }
                            
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct DiningTableListItem: View {
    @Bindable var dTable: DiningTable
    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .frame(width: 50)
                .foregroundColor(dTable.hexColor)
                .overlay {
                    Text(dTable.title.prefix(1))
                        .font(.title)
                        .foregroundStyle(dTable.hexColor)
                        .colorInvert()
                }
            VStack(alignment: .leading) {
                Text(dTable.title).font(.title2)
                Text(dTable.dateAdded.formatted(date: .abbreviated, time: .omitted)).foregroundStyle(.secondary)
                HStack {
                    if let raiting = dTable.raiting {
                        ForEach(0..<raiting, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundStyle(.yellow)
                        }
                    }
                }
                Text("2 pessoas").foregroundStyle(.secondary)
            }
            Spacer()
            Text("R$ 300,00")
        }
    }
}

#Preview {
    let preview = PreviewContainer(DiningTable.self)
    preview.addExamples(DiningTable.samplesDiningTable)
    return NavigationView {
        DiningTableListComponent()
    }
    .modelContainer(preview.container)
}
