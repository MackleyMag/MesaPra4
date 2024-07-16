//
//  NewPersonView.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 16/07/24.
//

import SwiftUI

struct NewPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let diningTable: DiningTable
    @State private var name = ""
    @State private var color = Color(uiColor: .random())
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Text("Nome da pessoa")
                    HStack {
                        TextField("Mariana", text: $name)
                        ColorPicker("", selection: $color, supportsOpacity: false)
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    createNewPerson()
                    dismiss()
                } label: {
                    Text("Salvar")
                }.disabled(name.isEmpty)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancelar")
                }
            }
        }
        .navigationTitle("Nova Pessoa")
    }
    
    fileprivate func createNewPerson() {
        if let hasPerson = diningTable.peopleInTable, !hasPerson.isEmpty {
            let person = PersonInTable(personName: name, color: color.toHexString()!)
            diningTable.peopleInTable?.append(person)
        } else {
            let person = PersonInTable(personName: name, color: color.toHexString()!)
            diningTable.peopleInTable?.append(person)
            modelContext.insert(person)
            diningTable.peopleInTable?.insert(person, at: 0)
        }
    }
}

#Preview {let preview = PreviewContainer(DiningTable.self)
    let diningTables = DiningTable.samplesDiningTable
    preview.addExamples(diningTables)
    
    return NavigationStack {
        NewPersonView(diningTable: diningTables[0])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
