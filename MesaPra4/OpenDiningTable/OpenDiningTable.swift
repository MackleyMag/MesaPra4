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
                HStack {
                    Spacer()
                    VStack {
                        Text("Consumo")
                        Divider()
                            .background(Color.red)
                            .frame(width: 60)
                    }
                    Spacer()
                    Divider()
                        .frame(height: 30)
                    Spacer()
                    VStack {
                        Text("Pessoas")
                        Divider()
                            .background(Color.secondary)
                            .frame(width: 60)
                    }
                    Spacer()
                }
            }
            
            ZStack(alignment: .bottomTrailing) {
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
                
                Button {
                    // Action
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)

                }
                .padding()
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
