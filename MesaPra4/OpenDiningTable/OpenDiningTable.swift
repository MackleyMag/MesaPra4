//
//  OpenDiningTable.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 30/06/24.
//

import SwiftUI
import SwiftData

struct OpenDiningTable: View {
    let diningTable: DiningTable
    @State private var selectedTab = 0
    @State private var showNewItem = false
    @State private var showNewPerson = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    if !diningTable.isClosed {
                        Text("Subtotal: R$30,00")
                    } else {
                        HStack {
                            if let total = diningTable.totalAmount  {
                                Text("Total da mesa: ")
                                Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                            }
                        }
                    }
                    HStack {
                        if let coverTip = diningTable.coverTip  {
                            Text("Covert: ")
                            Text(coverTip, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        }
                    }
                    if let tip = diningTable.tip  {
                        Text("Gorjeta: \(tip * 100)%")
                    }
                }
                Spacer()
                VStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bag.badge.plus")
                    })
                }
            }
            .navigationTitle(diningTable.title)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .background(diningTable.hexColor)
            
            VStack {
                Picker("", selection: $selectedTab){
                    Text("Consumo").tag(0)
                    Text("Pessoas").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal, 16)
            
            ZStack(alignment: .bottomTrailing) {
                switch(selectedTab) {
                case 1:
                    PeopleInTableView(diningTable: diningTable)
                default:
                    ItensInTableView(diningTable: diningTable)
                }
                
                HStack {
                    Button {
                        showNewItem.toggle()
                    } label: {
                        Text("Novo item")
                        Image(systemName: "plus")
                            .font(.body.weight(.semibold))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                        
                    }
                    .padding()
                    .sheet(isPresented: $showNewItem) {
                        NavigationStack {
                            NewDiningItemView(diningTable: diningTable)
                        }
                    }
                    Button {
                        showNewPerson.toggle()
                    } label: {
                        Text("Nova Pessoa")
                        Image(systemName: "plus")
                            .font(.body.weight(.semibold))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                        
                    }
                    .padding()
                    .sheet(isPresented: $showNewPerson) {
                        NavigationStack {
                            NewPersonView(diningTable: diningTable)
                                .presentationDetents([.medium])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer(DiningTable.self)
    let dinningTable = DiningTable.samplesDiningTable
    preview.addExamples(dinningTable)
    
    return NavigationView {
        OpenDiningTable(diningTable: dinningTable[0])
    }
    .modelContainer(preview.container)
}

struct ItensInTableView: View {
    @State var diningTable: DiningTable
    
    var body: some View {
        Group {
            if let diningItems = diningTable.diningItems, !diningItems.isEmpty {
                List {
                    ForEach(diningItems) { item in
                        OpenDiningTableListItem(dItem: item)
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("Agora que sua mesa está criada, adicione itens no botão azul", systemImage: "menucard")
            }
        }
    }
}

struct PeopleInTableView: View {
    @State var diningTable: DiningTable
    
    var body: some View {
        Group {
            if let people = diningTable.peopleInTable, !people.isEmpty {
                List {
                    ForEach(people) { person in
                        Text(person.personName)
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("Agora que sua mesa está criada, adicione pessoas no botão azul", systemImage: "person.3")
            }
        }
    }
}
