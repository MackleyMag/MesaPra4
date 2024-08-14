//
//  MultiSelectPickerView.swift
//  MesaPra4
//
//  Created by Mackley Magalhães da Silva on 04/07/24.
//

import SwiftUI

struct MultiSelectPickerView: View {
    // The list of items we want to show
    @State var allPeople: [PersonInTable]
    
    // Binding to the selected items we want to track
    @Binding var selectedPeople: [PersonInTable]
    
    var body: some View {
        Form {
            List {
                ForEach(allPeople, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedPeople.contains(item) {
                                // Previous comment: you may need to adapt this piece
                                self.selectedPeople.removeAll(where: { $0 == item })
                            } else {
                                self.selectedPeople.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedPeople.contains(item) ? 1.0 : 0.0)
                            Text(item.personName)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}
