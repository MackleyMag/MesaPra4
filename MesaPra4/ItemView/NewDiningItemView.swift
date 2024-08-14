//
//  NewDiningItemView.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 03/07/24.
//

import SwiftUI
import SwiftData

struct NewDiningItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let diningTable: DiningTable
    
    @State private var itemName = ""
    @State private var itemPrice: Decimal?
    @State private var itemType: DiningItemType = .snack
    
    @State private var peopleSelected: [PersonInTable] = []
    
    var body: some View {
        
        Form {
            VStack(alignment: .leading) {
                Text("Nome do item")
                TextField("Coca cola latinha", text: $itemName)
            }
            
            VStack(alignment: .leading) {
                Text("Valor do item")
                TextField("R$ 10,00", value: $itemPrice, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                    .keyboardType(.decimalPad)
            }
            Picker(selection: $itemType, label: Text("Categoria do item")) {
                ForEach(DiningItemType.allCases , id: \.id) { item in
                    Label(title: { Text(item.descr) },
                          icon: { Image(systemName: item.icon) }
                    ).tag(item.id)
                        .foregroundStyle(.primary)
                }
            }.pickerStyle(.inline)
            
            
            if let peopleInTable = diningTable.peopleInTable {
                Section(header: Text("Quem dividirá este item?"),
                        footer: Text("Você pode escolher as pessoas que dividirão este item mais tarde tocando nele na lista anterior.")) {
                    NavigationLink {
                        //                    if let peopleInTable = diningTable.peopleInTable {
                        MultiSelectPickerView(allPeople: peopleInTable, selectedPeople: $peopleSelected)
                            .navigationTitle("Escolha as pessoas")
                        //                    }
                    } label: {
                        HStack {
                            Text("Pessoas selecionadas:")
                                .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                            Spacer()
                            Image(systemName: "\($peopleSelected.count).circle")
                                .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .navigationTitle("Novo item")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Criar") {
                    createNewItem()
                    itemName = ""
                    itemPrice = nil
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(canCreateItemDisabled())
            }
        }
        
        
    }
    
    func canCreateItemDisabled() -> Bool {
        if let price = itemPrice, price > 0.0, !itemName.isEmpty {
            return false
        }
        return true
    }
    
    fileprivate func createNewItem() {
        if let hasDiningItens = diningTable.diningItems, !hasDiningItens.isEmpty {
            let item = DiningItem(itemName: itemName,
                                  itemPrice: itemPrice!,
                                  itemType: itemType.rawValue)
            if peopleSelected != [] {
                item.people = peopleSelected
            }
            diningTable.diningItems?.append(item)
        } else {
            let item = DiningItem(itemName: itemName,
                                  itemPrice: itemPrice!,
                                  itemType: itemType.rawValue)
            if peopleSelected != [] {
                item.people = peopleSelected
            }
            modelContext.insert(item)
            diningTable.diningItems?.insert(item, at: 0)
        }
    }
}

#Preview {
    let preview = PreviewContainer(DiningTable.self)
    let diningTables = DiningTable.samplesDiningTable
    preview.addExamples(diningTables)
    
    return NavigationStack {
        NewDiningItemView(diningTable: diningTables[0])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
