//
//  NewDiningTableView.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 30/06/24.
//

import SwiftUI

struct NewDiningTableView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var color = Color.orange
    @State private var tip: Decimal?
    @State private var coverTip: Decimal?
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Text("Dê um nome a sua mesa")
                        .font(.title3)
                    TextField("Restaurante do beltrano", text: $title)
                }
                VStack(alignment: .leading) {
                    ColorPicker("Escolha uma cor para a identificarmos a mesa", selection: $color, supportsOpacity: false)
                }
                
                VStack(alignment: .leading) {
                    Text("Informe a porcentagem da gorjeta")
                        .font(.title3)
                    HStack {
                        TextField("Se não tiver, deixe em branco", value: $tip, format: .percent)
                            .keyboardType(.decimalPad)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Informe o valor do cover, caso houver")
                        .font(.title3)
                    HStack {
                        TextField("Se não tiver, deixe em branco", value: $coverTip, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button("Criar mesa") {
                    let newDiningTable = DiningTable(
                        title: title, color: color.toHexString()!, tip: tip, coverTip: coverTip)
                    context.insert(newDiningTable)
                    dismiss()
                }
                .padding(.vertical, 16)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .listRowSeparator(.hidden)
                .disabled(title.isEmpty)
            }
            .navigationTitle("Nova Mesa")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewDiningTableView()
}
